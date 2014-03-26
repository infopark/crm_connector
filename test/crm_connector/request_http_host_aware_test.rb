# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class RequestHttpHostAwareTest < ConnectorTestCase
    def setup
      #Infopark::Crm.configure {|c| c.http_host = "test1.localdomain"}
    end

    def teardown
      #Infopark::Crm.configure {|c| c.http_host = "test1.localdomain"}
    end

    def pending_test_requests_are_sent_using_default_http_host
      locations = Location.find(:all)
      assert(locations.map(&:city).include?('Tenant1'))
      assert(!locations.map(&:city).include?('Tenant2'))
    end

    def pending_test_requests_are_sent_using_configured_http_host
      Infopark::Crm.configure {|c| c.http_host = "test2.localdomain"}
      locations = Location.find(:all)
      assert(locations.map(&:city).include?('Tenant2'))
      assert(!locations.map(&:city).include?('Tenant1'))
    end
  end

end; end
