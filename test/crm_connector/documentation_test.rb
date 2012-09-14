# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class DocumentationTest < ConnectorTestCase
    class << self
      def startup
        CrmSetup.custom_types
        @@activity = Activity.create(:kind => 'support case', :state=>'created', :title => 'act, show, test!')
      end
    end

    def test_activity_example
      activity = Infopark::Crm::Activity.new(:kind => 'support case')
      activity.title = 'Sprechen Sie Deutsch?'
      Infopark::Crm.configure {|c| c.locale = 'de'}

      assert_false(activity.save)
      assert_equal(activity.errors.to_hash, {:state=>["ist kein gültiger Wert"]})
    end

    def test_contact_example
      contact = Infopark::Crm::Contact.search(:params => {:login => 'root'}).first
      assert_equal(contact.login, 'root')
    end
  end

end; end
