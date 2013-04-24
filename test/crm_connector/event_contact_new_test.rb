# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class EventContactNewTest < ConnectorTestCase

    class << self
      def startup
        CrmSetup.custom_types
        e = Event.create(:title => 'Event',
            :dtstart_at => Time.now,
            :dtend_at => Time.now + 1.day,
            :custom_attributes => [
              { :name => 'breakfast', :type => 'string' },
              { :name => 'lunch', :type => 'string' }
            ],
            :kind => 'base event')
        @@event_id = e.id
      end
    end

    def test_can_access_static_properties_of_event_contact
      event_contact = EventContact.new
      assert_nil event_contact.state
      assert_nil event_contact.contact_id
      assert_nil event_contact.event_id
    end

    def test_can_access_custom_properties
      assert_nil EventContact.new.custom_never_set_before
      assert_nil EventContact.new.custom_whatever
    end

    def test_returns_state_when_saved
      c = Contact.create({:last_name => "X", :language => 'de', :gender => 'M', :want_geo_location => false})
      ec = EventContact.create(:contact_id => c.id, :event_id => @@event_id, :state => 'registered')

      assert_equal 'registered', EventContact.find(ec.id).state
    end

    def test_returns_custom_details_when_saved
      c = Contact.create({:last_name => "X", :language => 'de', :gender => 'M', :want_geo_location => false})
      ec = EventContact.create(:contact_id => c.id, :event_id => @@event_id, :state => 'registered',
        :custom_breakfast => 'extra bacon', :custom_lunch => 'no')

      ec_server = EventContact.find(ec.id)
      assert_equal 'extra bacon', ec_server.custom_breakfast
      assert_equal 'no', ec_server.custom_lunch
    end

  end
end; end
