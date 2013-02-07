# OmniAuth configuration for external authentication

# Uncomment this section if external autentication is being used.

#require "omniauth"

# OmniAuth logging configuration.  Defaults to STDOUT

#OmniAuth.config.logger = Rails.logger

# Central Authentication System (CAS) configuration
# OmniAuth CAS requires at least one of the following two configuration options:
#
#    url - Defines the URL of your CAS server (i.e. https://cas-auth.rpi.edu/cas)
#    host - Defines the host of your CAS server. Optional if using url
#    login_url - Defines the URL used to prompt users for their login information.
#                Defaults to /login If no host is configured, the host application's domain will be used.
#
# For additional configuration options and information, read https://github.com/dlindahl/omniauth-cas

#require "omniauth-cas"
#Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :cas, url: 'https://cas-auth.rpi.edu/cas/', login_url: '/cas/login', logout_url: '/cas/logout', service_validate_url: '/cas/serviceValidate'
#end