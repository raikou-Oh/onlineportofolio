class Education < ActiveRecord::Base  
  set_table_name :education_histories
  #set_primary_key :edu_id
  
  belongs_to :resume    
  
  def grade
    grade_selector.map {|d,e| 
      d if e==self.tingkat
    } 
  end
  
  def grade_selector
    return {
      "TK" => 0, 
      "SD" => 1, 
      "SMP" => 2, 
      "SMA" => 3,
      "S1" => 4,
      "S2" => 5,
      "S3" => 6
      }.sort{|a,b| a[1]<=>b[1]}   
  end   
end
