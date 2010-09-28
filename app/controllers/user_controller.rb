class UserController < ApplicationController     
  
  @@method_exception = [:sendmessage,:showproject,:showfile,:projectlist,:aboutuser]
  layout :set_layout
  before_filter :authorize,:except => @@method_exception
  before_filter :getuser,:only => @@method_exception
 
  def getuser
    @user = User.find(params[:id])
    @projects = @user.projects
    @resume = @user.resume
    begin
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid user #{params[:id]}" )
      flash[:notice] = "user yang dicari tidak ada"
      redirect_to :action => 'searchresult',:controller => "main"
    end
  end
  
  def showuser
    unless @user.open_resume || session[:uid]
      flash[:notice] = 'resume user yang bersangkutan tidak dapat dilihat. silahkan login terlebih dahulu'
      redirect_to :action => "projectlist",:id => params[:id]
    end
  end
    
  def sendmessage
    if params[:type]
      @message
      case params[:type]
        when 'offer' then begin
          @message = Offer.new(params[:message])
          @message.out = false
          @message.email = params[:email]
          @message.save
        end
        when 'message' then begin
          if session[:uid]
            @message = Message.new(params[:message])
            @message.sender = User.find(session[:uid])
            @message.user = @user
            @user.save(false)
            flash[:notice] = 'terima kasih, pesan sudah dikirimkan'
          else
            flash[:notice] = "pesan tidak dapat dikirimkan karena anda belum login"
          end
        end
      end      
    else
      flash[:notice] = 'pilih salah satu tipe pesan yang ingin anda kirimkan'
    end
    redirect_to :action => "aboutuser",:id => params[:id]
  end
  
def reviewproject
   if session[:uid] 
      @review = ProjectReview.new(params[:review])
      @review.save
      projectid = @review.project.id
      respond_to do |format|
        format.js
        format.html{ redirect_to :action => "showproject",:id => params[:owner] , :projectid => projectid } 
      end
    end
end

def reviewfile
   if session[:uid]
      @review = FileReview.new(params[:review])
      @review.save
      fileid = @review.file.id
      respond_to do |format|
          format.html {redirect_to :action => "showfile",:id => params[:owner], :fileid => fileid}
          format.js    
      end
    end
end

  def showproject          
    pid = params[:projectid]
    @project = @projects.find(pid)
    @review = ProjectReview.new
    rescue ActiveRecord::RecordNotFound
      logger.error("percobaan akses project gagal" )
      flash[:notice] = "user ini tidak memiliki project dengan kode #{pid}"
      redirect_to :action => 'projectlist',:id => params[:id]
  end
  
  def showfile
    pid = params[:fileid]
    @file = PFile.find(pid)
    @review = FileReview.new
    rescue ActiveRecord::RecordNotFound
      logger.error("percobaan akses file gagal" )
      flash[:notice] = "user ini tidak memiliki file dengan kode #{pid}"
      redirect_to :action => 'showproject',:id => params[:id],:projectid => ""
  end
    
  def authorize
    unless session[:uid] and user = User.find(session[:uid])
      session[:uid] = nil               
      flash[:notice] = "anda harus login terlebih dahulu sebelum menggunakan fasilitas ini"      
      redirect_to login_url
    else
      @logon_uid = session[:uid]
      @logon_uname = user.username
      @user = user
    end
  end
  
  private 
  def set_layout
    layout = "user"
    for ex in @@method_exception.each do
      layout = "templates" if params[:action].to_s == ex.to_s 
    end
    layout
  end
end
