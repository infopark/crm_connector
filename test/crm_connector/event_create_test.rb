# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class EventCreateTest < ConnectorTestCase
    class << self
      def startup
        CrmSetup.custom_types
      end
    end

    def test_create_event_should_be_successful
      assert_create_succeeds(Event, {
        :title => 'The Event',
        :dtstart_at => Time.now,
        :dtend_at => Time.now + 1.day,
        :custom_attributes => [
          { :name => 'breakfast', :type => 'string' },
          { :name => 'lunch', :type => 'string' }
        ],
        :kind => 'base-event'
        })
    end

    def test_create_event_by_save_should_be_successful
      assert_create_by_save_succeeds(Event, {
        :title => 'The other Event',
        :dtstart_at => Time.now,
        :dtend_at => Time.now + 1.day,
        :custom_attributes => [
          { :name => 'breakfast', :type => 'string' },
          { :name => 'lunch', :type => 'string' }
        ],
        :kind => 'base-event'
        })
    end

    def test_create_event_with_insufficient_properties_should_fail
      assert_create_fails(Event, :title => 'title')
    end

    def test_create_event_with_insufficient_properties_by_save_should_fail
      assert_create_by_save_fails(Event, :title => 'title')
    end

  end

end; end
