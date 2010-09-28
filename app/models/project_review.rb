class ProjectReview < ActiveRecord::Base
  set_table_name "projects_reviews"
  belongs_to :user
  belongs_to :project
end