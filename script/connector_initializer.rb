### Connector ###

require "pathname"
require File.dirname(__FILE__) + '/../lib/infopark_crm_connector'
require File.dirname(__FILE__) + '/../test/local_config'

Infopark::Crm.configure do |config|
  config.login = ENV['CRM_LOGIN'] || local_config['login']
  config.api_key = ENV['CRM_API_KEY'] || local_config['api_key']
  config.url = ENV['CRM_API_URL'] || local_config['url']
end

include Infopark::Crm
