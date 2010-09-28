class Message < ActiveRecord::Base
    belongs_to :user
    belongs_to :sender, :class_name => "User",:foreign_key => "use_user_id"
  
    belongs_to :message_group, :foreign_key => "msgroup_id"
  
    before_create :set_default
    
    validates_presence_of :pesan,:subjek,
      :message => "harus diisi"
    
    def self.find_by_sender(sender)
      self.find(:all,:conditions => ['use_user_id = ? and senderdelete = false',sender])
    end
    
    def destroy(doit)
      if doit == self.sender.id
        self.senderdelete = true
      elsif doit == self.user.id
        self.readerdelete = true
      end
      self.save(false)
      self.destroy if self.readerdelete and self.senderdelete        
    end
    
    private
    def set_default
      self.unread = true
      self.star = 0
    end
  
end
