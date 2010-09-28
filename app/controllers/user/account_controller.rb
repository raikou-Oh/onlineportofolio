class User::AccountController < UserController
  before_filter :thisuser
  
  def thisuser
    @user = User.find(@logon_uid)
    @templates = Temp.all
  end
  
  def index
    respond_to do |format|
      format.html
    end
  end
  
  def changepassword    
    if request.put?
      @user.validate_oldpass = true
      if @user.update_attributes(params[:user])
        UserMailer.deliver_changepassword(@user,params[:user][:password])
        redirect_to :controller => "account" ,:action => "index"
      end
    end
  end
  
  def update
    @user.validate_pass = false
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'account anda sudah terupdate.'
        format.html { redirect_to :action => "index",:controller => "account" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
