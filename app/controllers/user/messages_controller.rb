class User::MessagesController < UserController
  # GET /user_messages
  # GET /user_messages.xml  
  before_filter :group
  
  def group
    @msggroups = @user.message_groups
  end
  
  def show_message_by_group
    if params[:id]
      @messages = @msggroups.find(params[:id]).messages
    else 
      @messages = @msggroups.find(:all)
    end
    respond_to do |format|
      format.html { render :action => "index"}
      format.xml  { render :xml => @messages }
    end
  end
  
  def show_outbox_msg
    @message = Message.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def group_info
    @msggroup = @msggroups.find(param[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def many_selected    
    if params[:message_ids] and @messages = Message.find(params[:message_ids])
      count = @messages.count
      @messages.each do |msg|
        msg.destroy(params[:doit]) if params[:remove]
        msg.move_to_group(params[:group]) if params[:move]
      end  
      flash[:notice] = "berhasil menghapus #{count} pesan"
    else
      flash[:notice] = "tidak ada pesan yang dipilih"
    end    
    redirect_to user_messages_path
  end
  
  def reply
    @message = Message.new(params[:message])
    @message.save
      
    respond_to do |format|
      format.js
    end
  end
  
  def index    
    @messages = case params[:tipe]
      when 'inbox' then @user.messages.find_all_by_readerdelete(false)
      when 'outbox' then Message.find_by_sender(@logon_uid)
      when 'penting' then @user.messages.find_all_by_readerdelete_and_star(false,true)
      else @user.messages
    end
    #Message.find :all, :conditions => ["user_id = ? and tipe = ?",@logon_uid,params[:box]]
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /user_messages/1
  # GET /user_messages/1.xml
  def show
    @message = @user.messages.find(params[:id])    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /user_messages/new
  # GET /user_messages/new.xml
  def new
    @message = Message.new
    
    respond_to do |format|
      format.html # new.html.erb      
    end
  end

  # GET /user_messages/1/edit
  def edit
    @message = @user.messages.find(params[:id])
  end

  # POST /user_messages
  # POST /user_messages.xml
  def create
    @message = Message.new(params[:message])
    @message.user = User.find_by_username(params[:username])
    @message.sender = @user
    respond_to do |format|
        if @message.save
          flash[:notice] = 'pesan sudah terkirim.'
          format.html { render :action => "show" }       
        else
          format.html { render :action => "new" }
        end        
    end
  end

  # PUT 
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        flash[:notice] = 'User::Message was successfully updated.'
        format.html
        format.xml  { head :ok }
      else
        format.html { render :action => "show" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

end
