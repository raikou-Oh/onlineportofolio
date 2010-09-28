class User::PfilesController < UserController
before_filter :check_project, :only => :new 

def check_project
  unless params[:projectid]
    redirect_to( :controller => "user/projects" )
  end
end

  def many_selected    
    if params[:file_ids] and @pfiles = PFile.find(params[:file_ids])
      count = @pfiles.count      
      @pfiles.each do |f|
        f.destroy if params[:remove]        
      end  
      flash[:notice] = "berhasil menghapus #{count} file"
    else
      flash[:notice] = "tidak ada file yang dipilih"
    end
    redirect_to :controller => "user/projects", :action => "show", :id => params[:projectid]
  end

def new
  @pfile = PFile.new
  
  respond_to do |format|
    format.html  
  end
end

def show
  @pfile = PFile.find(params[:id])
end

def create
  @pfile = PFile.new(params[:pfile])
  project = Project.find(params[:projectid])
  project.parts << @pfile
  
  respond_to do |format|
    if project.save
      flash[:notice] = "files telah berhasil disimpan"
      format.html {redirect_to :action=> "show", :id => @pfile.id }
    else
      format.html {render :action => "new" } 
    end  
  end
  
end

end
