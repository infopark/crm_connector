# encoding: utf-8
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
      assert_equal({:state=>["ist kein gültiger Wert"]}, activity.errors.to_hash)
    end

    def test_contact_example
      contact = Infopark::Crm::Contact.search(:params => {:login => 'root'}).first
      assert_equal('root', contact.login)
    end
  end

end; end
