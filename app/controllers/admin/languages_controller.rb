class Admin::LanguagesController < AdminController  
  def index
    @languages = Language.all    
    @language = Language.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @languages }
    end
  end
  
  def edit
    @language = Language.find(params[:id])
    respond_to do |format|
      format.html { render :action => "index"}
      format.xml  { render :xml => @languages }
    end
  end
  
  # POST /admin_languages
  # POST /admin_languages.xml
  def create
    @language = Language.new(params[:language])

    respond_to do |format|
      if @language.save
        flash[:notice] = 'Language was successfully created.'
        format.html { redirect_to admin_languages_path }
        format.xml  { render :xml => @language, :status => :created, :location => @language }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @language.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @language = Language.find(params[:id])

    respond_to do |format|
      if @language.update_attributes(params[:language])
        flash[:notice] = 'Language was successfully updated.'
        format.html { redirect_to admin_languages_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @language.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_languages/1
  # DELETE /admin_languages/1.xml
  def destroy
    @language = Language.find(params[:id])
    @language.destroy

    respond_to do |format|
      format.html { redirect_to(admin_languages_url) }
      format.xml  { head :ok }
    end
  end
end
