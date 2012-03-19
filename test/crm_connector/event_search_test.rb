# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class EventSearchTest < ConnectorTestCase
    class << self
      def startup
        CrmSetup.custom_types
        if (Event.find(:all, :params => {:limit => 15}).within_limit.size < 15)
          15.times do
            dt = Time.now + 1.day
            Event.create(:title => 'E', :dtstart_at => dt, :dtend_at => dt, :kind => 'base event')
          end
          wait_for_indexer
        end
      end
    end

    def test_search_should_return_events
      result = Event.search(:params => {})
      assert_kind_of Event, result.first
      assert result.size > 9, "Result count #{result.size} should be many"
    end

    def test_unsuccessful_search
      result = Event.search(:params => {:kind => 'Theresnothinglikethis123'})
      assert_equal 0, result.size
      result = Event.search(:params => {:q => 'Theresnothinglikethis123'})
      assert_equal 0, result.size
    end

    def test_successful_search
      result = Event.search(:params => {:kind => 'base event'})
      assert_not_equal 0, result.size
    end

    def test_search_should_return_count
      result = Event.search(:params => {})
      assert result.size > 15, "Result count #{result.size} should be larger"
    end

    def test_search_should_return_items_in_continuation
      result = Event.search(:params => {:q => ''})
      size = result.map{}.size
      assert size > 15, "Result count #{size} should be larger"
    end
  end

end; end
