class User::ProjectsController < UserController    
  # GET /projects
  # GET /projects.xml
  
  def index
    @projects = @user.projects

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new
    @project.tools.build
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def show
    @project = @user.projects.find(params[:id])
  end

  def many_selected    
    if params[:project_ids] and @projects = @user.projects.find(params[:project_ids])
      count = @projects.count
      @projects.each do |project|
        project.destroy if params[:remove]
      end  
      flash[:notice] = "berhasil menghapus #{count} project"
    else
      flash[:notice] = "tidak ada project yang dipilih"
    end    
    redirect_to user_projects_path
  end

  # GET /projects/1/edit
  def edit
    @project = @user.projects.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml    
  def create
    @project = Project.new(params[:project])
    @user.projects << @project
    
    respond_to do |format|
      if @user.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to user_project_path(@project) }
      else        
        format.html { render :action => "new",:controller => "user/projects" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    params[:project][:tools] ||= {}
    @project = @user.projects.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to user_project_path(@project) }       
      else
        format.html { render :action => "edit" }        
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = @user.project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(user_projects_url) }
      format.xml  { head :ok }
    end
  end
  
end
