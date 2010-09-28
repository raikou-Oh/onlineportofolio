class Project < ActiveRecord::Base
  #set_primary_key :project_id
  after_update :save_dependent
  
  has_many :parts, 
    :class_name => "PFile"
    
  has_and_belongs_to_many :tools
  
  belongs_to :user
  has_many :reviews,:class_name => "ProjectReview"
  has_many :reviewer,:through => :reviews,:source => "user"
  
  attr_accessor :tool_list,:lang_list
  
  def is_reviewed_user(userid)
    return true if self.reviewer.find(userid)
  rescue ActiveRecord::RecordNotFound
      return false
  end
  
  def owner
    self.user.username  
  end
  
  def is_owner(userid)
    self.user.id == userid ? true : false
  end
  
  #before_create :generate_id  
  private
  def save_dependent
    tools.delete_all
    selected_tools = tool_list.nil? ? [] : tool_list.keys.collect{|id| Tool.find(id)}
    selected_tools.each {|tool| self.tools << tool}
  end
end
