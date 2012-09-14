### Connector ###
require File.dirname(__FILE__) + '/../lib/infopark_crm_connector'

### Connector configuration ###
Infopark::Crm.configure do |config|
  config.url = 'http://localhost:4000'
  config.login = 'root'
  config.api_key = 'rootrootrootroot'
end
