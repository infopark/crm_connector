# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class EventUpdateTest < ConnectorTestCase
    def setup
      CrmSetup.custom_types
      @event_name = "Event_#{Time.now.tv_sec}"
      @event = Event.create({
          :name => @event_name,
          :kind => 'base event',
          :title => 'Event title',
          :dtstart_at => Time.now,
          :dtend_at => Time.now + 2.days,
          })
    end

    def test_updating_an_event_should_be_successful
      assert_update_succeeds(@event, :title => 'Changed event title')
      assert_equal 'Changed event title', Event.find(@event.id).title
    end

    def test_updating_an_event_by_save_should_be_successful
      assert_update_by_save_succeeds(@event, :title => 'Another changed event title')
      assert_equal 'Another changed event title', Event.find(@event.id).title
    end

    def test_updating_an_event_with_invalid_properties_should_fail
      assert_update_fails(@event, :title => '')
      assert_validation_failed(@event, /Title muss ausgefüllt werden/)
    end

    def test_updating_an_event_with_invalid_properties_by_save_should_fail
      assert_update_by_save_fails(@event, :title => '')
      assert_validation_failed(@event, /Title muss ausgefüllt werden/)
    end
  end

end; end
