# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class EventContactFindTest < ConnectorTestCase

    class << self
      def startup
        CrmSetup.custom_types
        e = Event.create(:title => 'EventX',
            :dtstart_at => Time.now,
            :dtend_at => Time.now + 1.day,
            :kind => 'base event')
        @@event_id = e.id

        c = Contact.create({
            :last_name => "EislerX",
            :language => 'de',
            :gender => 'M',
            :want_geo_location => false
            })
        @@contact_id = c.id

        EventContact.create(:contact_id => @@contact_id, :event_id => @@event_id, :state => 'registered')
        wait_for_indexer
      end
    end

    def test_can_be_found_by_event_and_contact
      assert_not_nil EventContact.find_by_event_id_and_contact_id(@@event_id, @@contact_id)
    end

    def test_not_found_by_event_and_contact
      assert_raise ActiveResource::ResourceNotFound do
        EventContact.find_by_event_id_and_contact_id(0, 0)
      end
    end

    def test_find_by_event_and_contact_returns_properties
      ec = EventContact.find_by_event_id_and_contact_id(@@event_id, @@contact_id)
      assert_equal [@@event_id, @@contact_id, 'registered'], [ec.event_id, ec.contact_id, ec.state]
    end

    def test_can_be_found_by_event_id
      assert_not_nil EventContact.find_by(:params => {:event_id => @@event_id}).size
    end

    def test_find_by_returns_event_contacts
      ec = EventContact.find_by(:params => {:event_id => @@event_id}).first
      assert_kind_of EventContact, ec
    end

    def test_find_by_returns_event_contact_properties
      ec = EventContact.find_by(:params => {:event_id => @@event_id}).first
      assert_equal [@@event_id, @@contact_id, 'registered'], [ec.event_id, ec.contact_id, ec.state]
    end

  end
end; end
