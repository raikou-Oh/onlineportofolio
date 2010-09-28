class Admin::ToolsController < AdminController
  before_filter :all_tools
  
  def all_tools
    @tools = Tool.all
  end
  # GET /admin_tools
  # GET /admin_tools.xml
  def index
    if request.get? && !params[:id].blank? 
      @tool = Tool.find(params[:id])      
    elsif request.get? && params[:id].blank?
      @tool = Tool.new 
    end
  end

  # GET /admin_tools/1
  # GET /admin_tools/1.xml
  def show
    @tool = Tool.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tool }
    end
  end

  # POST /admin_tools
  # POST /admin_tools.xml
  def create
    @tool = Tool.new(params[:tool])

    respond_to do |format|
      if @tool.save
        flash[:notice] = 'Tool was successfully created.'
        format.html { redirect_to admin_tools_path }
        format.xml  { render :xml => @tool, :status => :created, :location => @tool }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @tool.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_tools/1
  # PUT /admin_tools/1.xml
  def update
      @tool = Tool.find(params[:id])
      if @tool.update_attributes(params[:tool])
        flash[:notice] = 'Tool was successfully updated.'
        redirect_to admin_tools_path
      else
        render :action=> 'index'
      end
  end

  # DELETE /admin_tools/1
  # DELETE /admin_tools/1.xml
  def destroy
    @tool = Tool.find(params[:id])
    @tool.destroy

    respond_to do |format|
      format.html { redirect_to(admin_tools_url) }
      format.xml  { head :ok }
    end
  end
end
