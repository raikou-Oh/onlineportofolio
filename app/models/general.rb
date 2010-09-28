class General < ActiveRecord::Base
  #set_primary_key :general_id
  belongs_to :resume
  
  before_create :generate_id
  
  private
  def generate_id 
      self.id = General.count + 1
  end
end
