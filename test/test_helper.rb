require File.dirname(__FILE__) + '/../lib/infopark_crm_connector'

gem 'test-unit', '>=2.4'
require 'securerandom'
require 'test/unit'
require 'webmock/test_unit'
WebMock.disable!
require File.dirname(__FILE__) + '/connector_test_helper'
require File.dirname(__FILE__) + '/local_config'

Infopark::Crm.configure do |config|
  config.login = ENV['CRM_LOGIN'] || local_config['login']
  config.api_key = ENV['CRM_API_KEY'] || local_config['api_key']
  config.url = ENV['CRM_API_URL'] || local_config['url']
end

module CrmSetup
  @custom_types = false

  def self.custom_types
    unless @custom_types
      @custom_types = true
      Infopark::Crm::CustomType.create(:kind => 'Activity', :name => "support case", :states => 'created') rescue nil
      Infopark::Crm::CustomType.create(:kind => 'Event', :name => 'base event', :states => []) rescue nil
      Infopark::Crm::CustomType.create(:kind => 'Activity', :name => 'note') rescue nil
      Infopark::Crm::CustomType.create(:kind => 'Event', :name => 'base event', :states => []) rescue nil
    end
  end
end

class ConnectorTestCase
end

Infopark::Crm::Core::Resource.deprecation_warnings = false
