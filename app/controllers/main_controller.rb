class MainController < ApplicationController
  layout "main"
  before_filter :sidebar_data
  
  def sidebar_data
    @normals = Language.normal
    @progs = Language.programming
    @tools = Tool.all
  end
  
  def search
      if (column = params[:in]) and (id = params[:id])
        class_name = column.camelize.constantize
        res = class_name.find(id)
        @results = res.resumes
        flash[:notice] = "anda mencari user dengan keahlian #{res.nama}"  
        render( :template => "main/searchresult" )
      elsif params[:search]
        
        @results = case params[:by]
          when 'resume' then ResumeSearch.new(params[:search]).resumes
          when 'project' then ProjectSearch.new(params[:search]).projects
        end
        if @results.count>0 
          render( :template => "main/searchresult" )
        else
          flash[:notice] = 'yang anda cari tidak ditemukan'
        end
      else 
        @searchresume = ResumeSearch.new
        @searchproject = ProjectSearch.new        
      end
        
  end
  
  def index
    render :layout => false
  end  
end
