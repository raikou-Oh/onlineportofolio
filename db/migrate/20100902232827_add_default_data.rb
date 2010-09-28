class AddDefaultData < ActiveRecord::Migration
  def self.up
    down
    
    Tool.create(:nama_tool => "Adobe Photoshop",:fungsi => "imaging")
    Tool.create(:nama_tool => "GIMP",:fungsi => "imaging")
    Tool.create(:nama_tool => "Adobe Illustrator",:fungsi => "imaging")
    Tool.create(:nama_tool => "Adobe Flash",:fungsi => "Animasi")
    Tool.create(:nama_tool => "Microsoft Office",:fungsi => "proses kata")
    Tool.create(:nama_tool => "Microsoft windows",:fungsi => "sistem operasi")
    Tool.create(:nama_tool => "Linux",:fungsi => "sistem operasi")
    Tool.create(:nama_tool => "Mac",:fungsi => "sistem operasi")
    Tool.create(:nama_tool => "Eclipse",:fungsi => "programming")
    Tool.create(:nama_tool => "NetBeans",:fungsi => "programming")
    Tool.create(:nama_tool => "Visual Studio",:fungsi => "programming")
    Tool.create(:nama_tool => "Delphi",:fungsi => "programming")
    Tool.create(:nama_tool => "SQL Server",:fungsi => "database")
    Tool.create(:nama_tool => "MySQL",:fungsi => "database")
    Tool.create(:nama_tool => "PostgreSQL",:fungsi => "database")
    Tool.create(:nama_tool => "sqlite",:fungsi => "database")
    Tool.create(:nama_tool => "Oracle",:fungsi => "database")    
        
    #tools.each do |tool|
    #  tool.save!
    #end
    
    Language.create(:language => "Inggris", :tipe => "normal")
    
    Language.create(:language => "Spanyol", :tipe => "normal")
    
    Language.create(:language => "Belanda", :tipe => "normal")
    
    Language.create(:language => "Mandarin", :tipe => "normal")
    
    Language.create(:language => "Perancis", :tipe => "normal")
    
    Language.create(:language => "Rusia", :tipe => "normal")
    
    Language.create(:language => "PHP", :tipe => "programming")
    
    Language.create(:language => "Ruby", :tipe => "programming")
    
    Language.create(:language => "Smalltalk", :tipe => "programming")
    
    Language.create(:language => "Python", :tipe => "programming")
    
    Language.create(:language => "Java", :tipe => "programming")
    
    Language.create(:language => "C++", :tipe => "programming")
    
    Language.create(:language => "Pascal", :tipe => "programming")
    
    Language.create(:language => "C#", :tipe => "programming")
    
    Language.create(:language => "ASP", :tipe => "programming")
    
    Language.create(:language => "ASP.NET", :tipe => "programming")
    
    Language.create(:language => "VB.NET", :tipe => "programming")   
    
    
  end

  def self.down
    Language.delete_all
  end
end

