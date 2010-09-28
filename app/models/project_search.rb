class ProjectSearch
  attr_accessor :tool_ids,
    :judul,
    :perusahaan,
    :haveurl,:lama_min,:lama_max
    
  def projects
       Project.find(:all, 
        :conditions => conditions,
        :group => 'projects.id',
        :joins => joins,
        :having => having,
        :select => 'projects.*')
  end
  
  def initialize(params=nil)
    params ||= {}
    params.each do |key, value|
      self.send("#{key}=", value)
    end
  end
  
  private      
    def joins
      :tools unless tool_ids.nil?      
    end
    
    def having
      "count(*)=#{tool_ids.count}" unless tool_ids.nil?
    end
    
    def tools_conditions
      ["tools.id in (?)", tool_ids] unless tool_ids.nil?
    end
    
    def judul_conditions
      ["judul like ?", '%'+judul+'%'] unless judul.blank?
    end
    
    def perusahaan_conditions
      ["perusahaan like ?", '%'+perusahaan+'%'] unless perusahaan.blank?
    end
    
     def lama_min_conditions
      ["lama_pengerjaan >= ?", lama_min] unless lama_min.to_i>=0 or lama_min.blank?
    end
    
    def lama_max_conditions
      ["lama_pengerjaan <= ?", lama_max] unless lama_max.to_i>0
    end
    
    def conditions
      [conditions_clauses.join(' AND '), *conditions_options]
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