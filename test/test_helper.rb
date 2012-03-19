require File.dirname(__FILE__) + '/../lib/infopark_crm_connector'
require File.dirname(__FILE__) + '/test_config'

gem 'test-unit', '>=2.4'
require 'test/unit'
require 'webmock/test_unit'
WebMock.disable!
require File.dirname(__FILE__) + '/connector_test_helper'

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

Infopark::Crm::Resource.deprecation_warnings = false
