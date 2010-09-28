class AdminController < ApplicationController
  before_filter :authorize_admin
  layout "user"  
    
  def authorize_admin
    if session[:uid] and user = User.find(session[:uid])
      unless user.admin
        flash[:notice] = "anda bukan seorang admin"
        redirect_to user_page_path      
      else
        @user = user
      end      
    end
  end
end
