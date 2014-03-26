# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class EventNewTest < ConnectorTestCase
    def test_can_access_static_properties_of_event
      @event = Event.new

      # this is a hash property
      assert_nil @event.custom_attributes
      assert_nil @event.dtend_at
      assert_nil @event.dtstart_at
      assert_nil @event.event_set
      assert_nil @event.kind
      assert_nil @event.location
      assert_nil @event.title
    end
  end
end; end
