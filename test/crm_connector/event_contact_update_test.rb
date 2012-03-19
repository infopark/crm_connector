# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class EventContactUpdateTest < ConnectorTestCase

    class << self
      def startup
        CrmSetup.custom_types
        e = Event.create(:title => 'Event',
            :dtstart_at => Time.now,
            :dtend_at => Time.now + 1.day,
            :details => 'breakfast, lunch',
            :kind => 'base event')

        c = Contact.create({
            :last_name => "EislerX",
            :language => 'de',
            :gender => 'M',
            :want_geo_location => false
            })

        @@event_contact = EventContact.create(:contact_id => c.id, :event_id => e.id, :state => 'registered', :custom_breakfast => 'eggs')
      end
    end

    def test_updating_a_event_contact_should_be_successful
      assert_update_succeeds(@@event_contact, :state => 'attended')
      assert_update_succeeds(@@event_contact, :custom_breakfast => 'bacon')
    end

    def test_updating_a_event_contact_by_save_should_be_successful
      assert_update_by_save_succeeds(@@event_contact, :state => 'refused')
      assert_update_by_save_succeeds(@@event_contact, :custom_breakfast => 'juice')
    end

    def pending_test_invalid_updating_a_event_contact_should_fail
      assert_update_fails(@@event_contact, :contact_id => nil)
    end

    def pending_test_invalid_updating_a_event_contact_by_save_should_fail
      assert_update_by_save_fails(@@event_contact, :contact_id => nil)
    end

  end

end; end
