class Language < ActiveRecord::Base
  has_and_belongs_to_many :resumes
  validates_presence_of :language
  
  def self.normal
    self.find :all, :conditions => ['tipe = ?','normal']  
  end
  
  def self.programming
    self.find :all, :conditions => ['tipe = ?', 'programming']  
  end
  
  def self.tipe
    ["normal", "programming"]
  end
  
  def nama
    "Bahasa #{self.language}(#{self.tipe})" 
  end
  
end
