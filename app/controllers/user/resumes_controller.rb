class User::ResumesController < UserController
  # GET /resumes
  # GET /resumes.xml
  before_filter :cek_user, :except => "index"
    
  def index
    @resume = @user.resume
    
    respond_to do |format|
      format.html
    end
  end

  def photo
    resume = @user.resume
    send_data(:content_type => resume.content_type,
      :data => resume.foto )
  end

  # GET /resumes/new
  # GET /resumes/new.xml
  def new
    @resume = Resume.new
    @resume.education_histories.build
    @resume.work_histories.build
    @resume.generals.build
    @resume.certifications.build
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @resume }
    end
  end
  
  # GET /resumes/1/edit
  def edit
    @resume = @user.resume
    @normals = Language.normal
    @progs = Language.programming
    @tools = Tool.all
  end

  # PUT /resumes/1
  # PUT /resumes/1.xml
  def update
    params[:resume][:existing_certification] ||= {}
    params[:resume][:existing_edu] ||= {}
    params[:resume][:existing_work] ||= {}
    params[:resume][:existing_general] ||= {}
    
    if params[:ot] and other=params[:othertool]
      other.split(',').each do |nama|
        tool = Tool.new(:nama_tool => nama)
        tool.save
        params[:resume][:tool_list][tool.id] = "1"
      end
    end
    
    if params[:onl] and other=params[:otnormlang]
      other.split(',').each do |nama|
        lang = Language.new(:language => nama,:tipe => 'normal')
        lang.save
        params[:resume][:lang_list][lang.id] = "1"
      end
    end
    
    if params[:opl] and other=params[:otproglang]
      other.split(',').each do |nama|
        lang = Language.new(:language => nama,:tipe => 'programming')
        lang.save
        params[:resume][:lang_list][lang.id] = "1"
      end
    end
    
    respond_to do |format|
      if @resume.update_attributes(params[:resume])
        flash[:notice] = 'Resume was successfully updated.'
        format.html { redirect_to user_resumes_path }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  private
  def cek_user
    unless Resume.find(params[:id]).user.id == session[:uid]
      if session[:uid]
        redirect_to user_page_url
      else
        redirect_to :controller => "main"
      end
    end
  end
end
