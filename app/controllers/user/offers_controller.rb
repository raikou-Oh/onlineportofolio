class User::OffersController < UserController
  
  def index
    @offers = @user.offers
  end
  
  def show
    @offer = @user.offers.find(params[:id])
  end
  
  def new
    @offer = Offer.new 
  end
  
  def create
    @offer = Offer.new(params[:offer]) if params[:offer]
    @user.offers << @offer
    
    respond_to do |format|        
      if @user.save || @offer.save
        UserMailer.deliver_jobapplication(@offer,@user)
        flash[:notice] = "anda sudah mengirimkan aplikasi pekerjaan"        
        format.html {redirect_to :action => "index"}
      else
        format.html {render :action => "new"}
      end
    end
  end
  
end
