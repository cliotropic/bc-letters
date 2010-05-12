# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bc-letters_session',
  :secret      => 'eb09f3dd6e3947e758e1d860bf769f9f936c147f4a3b9e0d9d86e8aabe572633b4d2ab42ae9cf7e34298d00ceedbe5027c84d2edd04553c1587d25077e54528d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
