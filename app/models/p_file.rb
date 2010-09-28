class PFile < ActiveRecord::Base
  before_create :fill_info
  set_table_name 'pfiles'  
  #set_primary_key :file_id  
  
  belongs_to :project  
  
  has_many :reviews, :class_name => "FileReview", :foreign_key => :file_id
  has_many :reviewer, :through => :reviews, :source => "user"

  validates_presence_of :judul,:deskripsi,:message => "harus diisi"
  
  def is_owner(userid)
    userid!=nil && self.project.user.id == userid ? true : false 
  end
  
  def owner
    self.project.user.username 
  end
  
  def is_reviewed_user(userid)
    return true if self.reviewer.find(userid)
  rescue ActiveRecord::RecordNotFound
    return false
  end
  
  def self.get_project
    self.project
  end
  
  private
  def fill_info    
    self.flag = true
    #self.id  = "F" + (PFile.count+1).to_s
  end
end
