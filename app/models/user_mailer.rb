class UserMailer < ActionMailer::Base
  
 helper :application
 
  def activation_link(user)
    subject 'Aktifasi User di Onlineportfolio.co.cc'
    recipients user.email
    content_type 'text/plain'
    from '206115574@rudykurniawan.co.cc'
    body :user => user
  end
  
  def changepassword(user,passw)
    subject 'Konfirmasi perubahan Kata sandi untuk onlineportfolio.co.cc'
    recipients user.email
    content_type 'text/plain'
    from '206115574@rudykurniawan.co.cc'
    body :passw => passw,:user => user
  end
  
  def newpassword(user,passw)
    subject 'Konfirmasi permintaan kata sandi baru untuk onlineportfolio.co.cc'
    recipients user.email
    content_type 'text/plain'
    from '206115574@rudykurniawan.co.cc'
    body :passw => passw,:user => user
  end
  
  def jobapplication(offer,user)
    subject offer.subjek
    recipients offer.email
    from '206115574@rudykurniawan.co.cc'
    body :pesan => offer.pesan,:resume => user.resume
  end
end
