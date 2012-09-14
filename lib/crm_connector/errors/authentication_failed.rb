module Infopark; module Crm; module Errors

  ##
  # Raised when a contact provides wrong credentials (token/password)
  #
  # This differs from the case when the web services API credentials are not accepted
  # (an ActiveResource error is raised then)
  class AuthenticationFailed < Base; end

end; end; end