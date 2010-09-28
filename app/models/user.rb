require "digest/sha1"

class User < ActiveRecord::Base   
  has_one :resume, :dependent => :destroy   
   
  has_many :projects, :dependent => :destroy
  has_many :messages, :order => "created_at desc", :dependent => :destroy
   
  has_many :message_sent,:class_name => "Message", :foreign_key => "use_user_id"
  has_many :message_groups, :dependent => :destroy
  has_many :offers
  
  has_many :reviewed_files,
    :class_name => 'File',
    :through => :pfile_review
   
  has_many :reviewed_projects,
    :class_name => 'Project',
    :through => :project_review
   
  belongs_to :template,:class_name => "Temp"
      
  before_create :generate_default
   
  attr_accessor :password_confirmation,
    :validate_pass,
    :validate_oldpass,
    :oldpassword
      
  validates_presence_of :username,:email, :message => "harus diisi"
  validates_presence_of :password, :message => "harus diisi",
    :if => :should_validate_pass?
  validates_confirmation_of :password, :message => "tidak cocok dengan konfirmasi",
    :if => :should_validate_pass?

  validates_uniqueness_of :username, :message => "sudah terdaftar"
  validate :templateValid?
  validate :oldpasswordValid?, :if => :validate_oldpass
   
   def self.find_except(uid)
     self.find(:all, :conditions => [" id <> ? ",uid] )
   end
   
   def self.find_by_emailorname(text)
     self.find(:first, :conditions => ["username = ? or email = ?",text,text] )
   end
   
   def createnewpassword
     newpass = ActiveSupport::SecureRandom.base64(6)
     self.password = newpass
     self.save
     newpass
   end

   def password
     @pass
   end
   
   def password=(pwd)
     @pass=pwd
     return if pwd.blank?
     @pass_backup = self.pass
     @salt_backup = self.salt
     self.salt = ActiveSupport::SecureRandom.base64
     self.pass = User.encrypted_password(@pass, self.salt)
   end
   
   def self.authenticated(u,p)
     user = self.find :first, :conditions => ["username = ? and activated = true" ,u]
     if user
       user = nil unless user.pass == encrypted_password(p,user.salt)
     end
     user
   end
   
   def activate
     unless self.nil? 
       self.activationcode = nil
       self.activated = true
       self.save
       true
     else
       false
     end
   end
   
   private
    def oldpasswordValid?
      oldp = User.encrypted_password(self.oldpassword,@salt_backup)      
      unless @pass_backup==oldp
        errors.add("password lama", "tidak cocok")
      end
    end

    def should_validate_pass?
      validate_pass || validate_oldpass || new_record?
    end
   
    def templateValid?
      if User.all.any?
        errors.add(" ","anda belum memilih template") if self.template_id.blank?
      end       
    end
   
    def self.encrypted_password(pass,salt)
      string_to_hash = pass + salt
      Digest::SHA1.hexdigest(string_to_hash)
    end
    
    def generate_default
      if User.all.count==0
        self.activated = true #self.admin = true
        self.activationcode = nil
      else
        self.activated = self.admin = false
        self.activationcode = ActiveSupport::SecureRandom.base64(25)
      end
    end
end
