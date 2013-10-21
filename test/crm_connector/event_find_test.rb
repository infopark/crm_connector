# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class EventFindTest < ConnectorTestCase

    class << self
      def startup
        CrmSetup.custom_types
        e = Event.new(:title => 'The boring stuff',
            :dtstart_at => Time.now,
            :dtend_at => Time.now + 1.day,
            :custom_attributes => [
              { :name => 'breakfast', :type => 'string' },
              { :name => 'lunch', :type => 'string' }
            ],
            :kind => 'base event')
        e.save!
        @@event_id = e.id
      end
    end

    def test_find_all_should_return_a_list_of_all_open_events
      eventually do
        events = Event.find(:all)
        assert_kind_of Enumerator, events
        assert_kind_of Event, events.first
        assert events.any?{|e| e.title == "The boring stuff"}
        assert !events.any?{|e| e.title == 'Party all the time'}
      end
    end

    # @webcrm_todo include_closed deprecated?
    def pending_test_find_all_with_including_closed_should_return_a_list_of_all_events
      events = Event.find_all_with_filter(:include_closed => true)
      assert_kind_of Array, events
      assert_kind_of Event, events.first
      assert events.any?{|e| e.title == 'Party all the time'}
    end

    def test_find_by_id_should_return_the_event
      eventually do
        event = Event.find(@@event_id)
        assert_equal "The boring stuff", event.title
      end
    end

    def test_find_by_id_with_a_nonexisting_id_should_raise_an_error
      assert_raise ActiveResource::ResourceNotFound do
        Event.find(123456)
      end
    end

    def test_find_by_id_with_null_should_raise_an_error
      assert_raise ActiveResource::ResourceNotFound do
        Event.find(nil)
      end
    end

  end

end; end
