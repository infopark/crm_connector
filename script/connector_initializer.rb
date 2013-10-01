### Connector ###

require "pathname"
require File.dirname(__FILE__) + '/../lib/infopark_crm_connector'
require File.dirname(__FILE__) + '/../test/local_config'

Infopark::Crm.configure do |config|
  config.login = local_config['login']
  config.api_key = local_config['api_key']
  config.url = local_config['url']
end

include Infopark::Crm
