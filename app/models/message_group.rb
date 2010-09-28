class MessageGroup < ActiveRecord::Base
  #set_primary_key :msgroup_id  
  
  belongs_to :user
  
  has_many :messages,:foreign_key => "msgroup_id"  
  
end
