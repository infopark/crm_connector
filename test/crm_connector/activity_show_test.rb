# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class ActivityShowTest < ConnectorTestCase
    class << self
      def startup
        CrmSetup.custom_types
        @@activity = Activity.create(:kind => 'support case', :state=>'created', :title => 'act, show, test!')
      end
    end

    def test_show_activity_should_fetch_activity_for_id
      activity = assert_show_succeeds(Activity, @@activity.id)
      assert_kind_of Activity, activity
      assert_property(activity, :title, 'act, show, test!')
    end

    def test_show_activity_for_wrong_id_should_fail
      assert_show_fails(Activity, 9999)
    end

    def test_show_activity_with_null_should_fail
      assert_show_fails(Activity, nil)
    end

    def test_show_activtity_contact_object
      contact_id = Contact.create(:gender => 'M', :language => 'en', :last_name => 'Requester').id
      @@activity.contact_id = contact_id
      @@activity.save

      assert_not_nil(@@activity.contact)
      assert_kind_of(Contact, @@activity.contact)
      assert_equal('Requester', @@activity.contact.last_name)
    end

    def test_show_activtity_contact_object_with_no_contact_should_return_nil
      @@activity.contact_id = nil
      @@activity.save

      assert_nil(@@activity.contact)
    end

    def test_show_activtity_account_object
      account_id = Account.create(:name => 'Requester AG').id
      @@activity.account_id = account_id
      @@activity.save

      assert_not_nil(@@activity.account)
      assert_kind_of(Account, @@activity.account)
      assert_equal('Requester AG', @@activity.account.name)
    end

    def test_show_activtity_account_object_with_no_account_should_return_nil
      @@activity.account_id = nil
      @@activity.save

      assert_nil(@@activity.account)
    end

    def test_show_activtity_custom_type_object
      assert_not_nil(@@activity.custom_type)
      assert_kind_of(CustomType, @@activity.custom_type)
      assert_equal(['created'], @@activity.custom_type.states)
    end

    def test_show_activtity_custom_type_object_with_no_custom_type_should_return_nil
      @@activity.kind = nil
      @@activity.save

      assert_nil(@@activity.custom_type)
    end
  end

end; end
