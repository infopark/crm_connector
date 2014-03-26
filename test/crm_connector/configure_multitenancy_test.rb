# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class ConfigureMultitenancyTest < ConnectorTestCase
    def teardown
      #Infopark::Crm.configure {|c| c.http_host = "test1.localdomain"}
    end

    def pending_test_contact_should_reset_cache_on_configure
      subscriptions = Contact.send(:cached_lookup_options, 'subscriptions')
      Infopark::Crm.configure { |config| config.http_host = "test2.localdomain" }
      assert_not_same subscriptions, Contact.send(:cached_lookup_options, 'subscriptions')
    end
  end

end; end
