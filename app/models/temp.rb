class Temp < ActiveRecord::Base
  #set_primary_key :template_id
  set_table_name :templates
  has_many :users,:foreign_key => "template_id"
  validate :css_valid
  validates_format_of :content_type,
    :with => /^image/,
    :message => "hanya bisa berisi file gambar",
    :if => Proc.new{|p| !p.thumb}
    
  after_save :save_file, 
    :if => Proc.new{|p| p.thumb}  
  
  @@thumb_dir = "template"
  
  def uploaded_file=(file)
    self.data = file.read
    self.file_type = file.content_type
  end
  
  def thumb_picture=(pic)
    self.content_type = pic.content_type    
    @thumb = pic
  end

  def base_part_of(file_name)
    File.basename(file_name).gsub(/[^\w._-]/, '' )
  end
  
  def type
    self.content_type.gsub(/image\//, '' )
  end
  
  def picture_link
    filename = @@thumb_dir+"/#{self.id}.#{self.type}"    
    if File.exists?('public/images/'+filename)
      filename
    else
      'nothing.png'
    end    
  end   
  
private
  def save_file
    name = self.id.to_s+'.'+type
    # create the file path
    path = File.join("public/images/"+@@thumb_dir, name)
    # write the file
    File.open(path, "wb") { |f| f.write(@thumb.read) }
  end
  
  def file_type=(ct)
    @file_type = ct
  end
  
  def file_type
    @file_type
  end
  
  def css_valid
    errors.add("is not css file") if not file_type=="text/css"
  end
end
