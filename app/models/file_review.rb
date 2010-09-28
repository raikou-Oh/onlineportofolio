class FileReview < ActiveRecord::Base
  set_table_name :pfiles_reviews
  
  belongs_to :user
  belongs_to :pfile
end