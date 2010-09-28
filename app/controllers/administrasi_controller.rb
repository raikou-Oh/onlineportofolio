class AdministrasiController < MainController  
  before_filter :online_user, :only => ["register", "login"]
  before_filter :get_template
    
  def get_template
    @templates = Temp.all
  end
  
  def online_user
    if session[:uid]
      redirect_to user_page_path
    end    
  end
  
  def verify
    unless params[:hash_key] and user = User.find_by_activationcode(params[:hash_key])
      flash[:notice] = "kode aktifasi tidak ditemukan"
    else
      if user.activate
        flash[:notice] = "account anda sudah diaktifkan, silahkan login"
        redirect_to login_path
      end
    end
  end
      
  def login
    if request.post?
      user = User.authenticated(params[:uname],params[:pass])
      if user
        session[:uid] = user.id
        @logon_uname = user.username
        flash[:notice] = ""
        if user.admin
          redirect_to(:controller => "admin")
        else
          redirect_to(:controller => "main")
        end
      else
        flash[:notice] = "username atau kata sandi yang dimasukkan tidak sesuai"
      end      
    end    
  end  
  
  def forgot
    if user = User.find_by_emailorname(params[:name])      
      passw = user.createnewpassword      
      UserMailer.deliver_newpassword(user,passw)
      flash[:notice] = "password baru anda sudah dikirimkan melalui email"
      redirect_to :action => "login"
    end
  end
  
  def logout
    session[:uid] = nil
    @logon_uid = nil
    flash[:notice] = "anda sudah keluar dari situs"
    redirect_to :controller => "main"
  end  
  
  def register
    @user = User.new  
    respond_to do |format|
      format.html
    end
  end
  
  def create    
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        resume = Resume.new
        resume.user = @user
        resume.save!
        UserMailer.deliver_activation_link(@user) if User.all.count>1
        format.html { redirect_to login_url }
      else
        format.html { render :action => "register" }
      end
    end
  end

end
