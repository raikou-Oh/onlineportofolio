class Admin::TempsController < AdminController
  # GET /templates
  # GET /templates.xml
  def index
    @temps = Temp.all

    respond_to do |format|
      format.html # index.html.erb      
    end
  end

  # GET /temps/1
  # GET /temps/1.xml
  def show
    @temp = Temp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /temps/new
  # GET /temps/new.xml
  def new
    @temp = Temp.new

    respond_to do |format|
      format.html # new.html.erb      
    end
  end

  # POST /temps
  # POST /temps.xml
  def create
    @temp = Temp.new(params[:temp])
  
    respond_to do |format|
      if @temp.save
        flash[:notice] = 'temp was successfully created.'
        format.html { redirect_to admin_temp_url(@temp) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
# GET /temps/1/edit
  def edit
    @temp = Temp.find(params[:id])
  end
  
  # PUT /temps/1
  # PUT /temps/1.xml
  def update
    @temp = Temp.find(params[:id])

    respond_to do |format|
      if @temp.update_attributes(params[:temp])
        flash[:notice] = 'temp was successfully updated.'
        format.html { redirect_to admin_temp_url(@temp) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /temps/1
  # DELETE /temps/1.xml
  def destroy
    @temp = temps.find(params[:id])
    @temp.destroy

    respond_to do |format|
      format.html { redirect_to(admin_temps_url) }
      format.xml  { head :ok }
    end
  end
end
