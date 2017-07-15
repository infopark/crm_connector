### Connector ###

require "pathname"
require File.dirname(__FILE__) + '/../lib/infopark_crm_connector'

Infopark::Crm.configure do |config|
  config.login = ENV['CRM_LOGIN']
  config.api_key = ENV['CRM_API_KEY']
  config.url = ENV['CRM_API_URL'] || "https://#{ENV['CRM_TENANT']}.crm.infopark.net"
end

include Infopark::Crm
