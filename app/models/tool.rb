class Tool < ActiveRecord::Base
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :resumes

  def nama
    self.nama_tool
  end
  
end
