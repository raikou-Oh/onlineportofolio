require 'resolv'

class Offer < ActiveRecord::Base
  belongs_to :user
  
  EMAIL_PATTERN = /(\S+)@(\S+)/
  SERVER_TIMEOUT = 3 # seconds
  
  validates_presence_of :email
  
  validates_format_of :email,:with => EMAIL_PATTERN   
      
  def valid_domain?(email)
    domain = email.match(EMAIL_PATTERN)[2]
    dns = Resolv::DNS.new
    Timeout::timeout(SERVER_TIMEOUT) do
      # Check the MX records
      mx_records = dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
        
      mx_records.sort_by {|mx| mx.preference}.each do |mx|
        a_records = dns.getresources(mx.exchange.to_s,
                        Resolv::DNS::Resource::IN::A)
        return true if a_records.any?
      end
      # Try a straight A record
      a_records = dns.getresources(domain, Resolv::DNS::Resource::IN::A)
      a_records.any?
    end
  rescue Timeout::Error, Errno::ECONNREFUSED
    false
  end
  
  
end