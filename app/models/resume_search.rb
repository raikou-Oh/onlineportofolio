class ResumeSearch
  attr_accessor :bidang, 
    :kota, 
    :work_min,:gaji_max, 
    :gaji_min,:umur_min, 
    :umur_max,:tool_ids,
    :language_ids
    
  def resumes
    @resumes ||= find_resumes
  end
  
  def initialize(params=nil)
    params ||= {}
    params.each do |key, value|
      self.send("#{key}=", value)
    end
  end
  
  private
    def find_resumes
      Resume.find(:all, :conditions => conditions,
        :group => 'resumes.id',
        :joins => joins,
        :having => having,
        :select => 'resumes.*')
    end
    
    def joins
      @joins = Array.new
      @joins << :tools unless tool_ids.nil?
      @joins << :languages unless language_ids.nil?
      @joins unless @joins.empty?
    end
    
    def having
      count = 1
      count *= tool_ids.count unless tool_ids.nil?
      count *= language_ids.count unless language_ids.nil?
      "count(*)=#{count}"
    end
    
    def bidang_conditions
      ["resumes.bidang LIKE ?", "%#{bidang}%"] unless bidang.blank?
    end
    
    def kota_conditions
      ["resumes.kota LIKE ?", "%#{kota}%"] unless kota.blank?
    end
    
    def tools_conditions
      ["tools.id in (?)",tool_ids] unless tool_ids.nil?
    end
    
    def languages_conditions
      ["languages.id in (?)", language_ids] unless language_ids.nil?
    end
    
    def gaji_min_conditions
      ["resumes.gaji >= ?", gaji_min] unless gaji_min.blank?
    end
    
    def gaji_max_conditions
      ["resumes.gaji <= ?", gaji_max] unless gaji_max.blank? or gaji_max.to_i<=0
    end
    
    def work_min_conditions
      ["resumes.pengalaman >= ?", work_min] unless work_min.blank?
    end
    
    def conditions
      [conditions_clauses.join(" AND "), *conditions_options]
    end
    
    def conditions_clauses
      conditions_parts.map { |condition| condition.first }
    end
    
    def conditions_options
      conditions_parts.map { |condition| condition[1..-1].flatten }
    end
    
    def conditions_parts
      private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
    end
end