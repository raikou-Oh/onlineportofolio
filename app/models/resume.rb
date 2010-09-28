class Resume < ActiveRecord::Base
  after_update :save_all
  
  has_and_belongs_to_many :tools
  has_and_belongs_to_many :languages, :order => :tipe
  
  has_many :education_histories, :class_name => "Education", :dependent => :destroy
  has_many :work_histories, :class_name => "Work", :dependent => :destroy
  has_many :certifications, :dependent => :destroy
  has_many :generals, :dependent => :destroy
  
  belongs_to :user
  attr_accessor :tool_list,:lang_list
  
  validates_format_of :content_type,
    :with => /^image/,
    :message => 'harus berisi file gambar',:if => :imageValid?
  
  def photo=(pic)
    self.foto = pic.read
    self.content_type = pic.content_type
  end
  
  def should_validate?
    not new_record?
  end
  
  def imageValid?
    if self.foto then true else false end
  end
  
  def gender_selector
    return {"laki-laki" => "M", "perempuan" => "P"}
  end
  
  def marital_selector
    return {"Single" => "1", "Menikah" => "2", "Bercerai" => "3" }.sort{|a,b| a[1]<=>b[1]}   
  end
  
  def gender
    gender_selector.map {|d,e| 
      d if e==self.jenis_kelamin
    }
  end
  
  def marital_status
    #self.marital
    marital_selector.map {|d,e| 
      d if e==self.marital
    } 
  end
  
  def existing_certification=(certification_attributes)
    certifications.reject(&:new_record?).each do |certification|
      attributes = certification_attributes[certification.id.to_s]
      if attributes
        certification.attributes = attributes
      else
        certifications.delete(certification)
      end
    end
  end
  
  def new_certification=(certification_attributes)
    certification_attributes.each do |attributes|
      certifications.build(attributes)
    end
  end
  
  def existing_edu=(education_attributes)
    education_histories.reject(&:new_record?).each do |edu|
      attributes = education_attributes[edu.id.to_s]
      if attributes
        edu.attributes = attributes
      else
        education_histories.delete(edu)
      end
    end
  end
  
  def new_edu=(education_attributes)
    education_attributes.each do |attributes|
      education_histories.build(attributes)
    end
  end
  
  def existing_work=(attr)
    work_histories.reject(&:new_record?).each do |work|
      attributes = attr[work.id.to_s]
      if attributes
        work.attributes = attributes
      else
        work_histories.delete(work)
      end
    end
  end
  
  def new_work=(attr)
    attr.each do |attributes|
      work_histories.build(attributes)
    end
  end
  
  def existing_general=(attr)
    generals.reject(&:new_record?).each do |general|
      attributes = attr[general.id.to_s]
      if attributes
        general.attributes = attributes
      else
        generals.delete(work)
      end
    end
  end
  
  def new_general=(attr)
    attr.each do |attributes|
      generals.build(attributes)
    end
  end
  
  private  
  def save_all
    education_histories.each {|i| i.save(false)}
    work_histories.each {|i| i.save(false)}
    generals.each {|i| i.save(false)}
    certifications.each {|i| i.save(false)}
    
    tools.delete_all
    selected_tools = tool_list.nil? ? [] : tool_list.keys.collect{|id| Tool.find(id)}
    selected_tools.each {|tool| self.tools << tool}
    
    languages.delete_all
    selected_languages = lang_list.nil? ? [] : lang_list.keys.collect{|id| Language.find(id)}
    selected_languages.each {|lang| self.languages << lang}
  end
end
