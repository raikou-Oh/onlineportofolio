class Work < ActiveRecord::Base
   set_table_name :work_histories
   #set_primary_key :work_id
   
   belongs_to :resume
   
end
