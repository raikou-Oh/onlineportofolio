# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_TA_session',
  :secret      => 'b5519627b40bce08e47684a5fdb4927abe837ec521d80e061b4d3b340929bdcb45b4a907d40ff7137ee3748395d40c7560a3f46228ccb223154ee0447889cc22'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
