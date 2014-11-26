# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class EventContactShowTest < ConnectorTestCase

    class << self
      def startup
        CrmSetup.custom_types
        e = Event.create(:title => 'A Event',
            :dtstart_at => Time.now,
            :dtend_at => Time.now + 1.day,
            :custom_attributes => [
              { :name => 'breakfast', :type => 'string' },
              { :name => 'lunch', :type => 'string' }
            ],
            :kind => 'base-event')

        c = Contact.create({
            :last_name => "Eisler",
            :language => 'de',
            :gender => 'M',
            :want_geo_location => false
            })

        @@event_contact_id = EventContact.create(:contact_id => c.id, :event_id => e.id, :state => 'registered').id
      end
    end

    def test_show_event_contact_should_fetch_event_contact_for_id
      event_contact = assert_show_succeeds(EventContact, @@event_contact_id)
      assert_kind_of EventContact, event_contact
      assert_property(event_contact, :state, 'registered')
    end

    def test_show_event_contact_for_wrong_id_should_fail
      assert_show_fails(EventContact, 9999)
    end

    def test_show_event_contact_with_null_should_fail
      assert_show_fails(EventContact, nil)
    end

    def test_show_event_contact_contact_object
      event_contact = EventContact.find(@@event_contact_id)

      assert_not_nil(event_contact.contact)
      assert_kind_of(Contact, event_contact.contact)
      assert_equal('Eisler', event_contact.contact.last_name)
    end

    def test_show_event_contact_event_object
      event_contact = EventContact.find(@@event_contact_id)

      assert_not_nil(event_contact.event)
      assert_kind_of(Event, event_contact.event)
      assert_equal('A Event', event_contact.event.title)
    end

  end
end; end
