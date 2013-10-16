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
        end
      end
    end

    def test_search_should_return_events
      eventually do
        result = Event.search(:params => {})
        assert_kind_of Event, result.first
        assert result.size > 9, "Result count #{result.size} should be many"
      end
    end

    def test_unsuccessful_search
      eventually do
        result = Event.search(:params => {:kind => 'Theresnothinglikethis123'})
        assert_equal 0, result.size
      end
      eventually do
        result = Event.search(:params => {:q => 'Theresnothinglikethis123'})
        assert_equal 0, result.size
      end
    end

    def test_successful_search
      eventually do
        result = Event.search(:params => {:kind => 'base event'})
        assert_not_equal 0, result.size
      end
    end

    def test_search_should_return_count
      eventually do
        result = Event.search(:params => {})
        assert result.size > 15, "Result count #{result.size} should be larger"
      end
    end

    def test_search_should_return_items_in_continuation
      eventually do
        result = Event.search(:params => {:q => '', :limit => 10})
        assert_equal result.take(14).size, 14
      end
    end

    def test_sort_by_updated_at_works
      search_params = {:sort_by => 'updated_at', :limit => 15}
      eventually do
        result = Event.search(:params => search_params).within_limit.to_a
        assert 15 <= result.size, "Result count #{result.size} should be larger"
        timestamps = result.map(&:updated_at)
        assert_equal timestamps.sort, timestamps, 'not sorted correctly'
      end
    end

    def test_sort_by_updated_at_asc_works
      search_params = {:sort_by => 'updated_at', :sort_oder => 'asc', :limit => 15}
      eventually do
        result = Event.search(:params => search_params).within_limit.to_a
        assert 15 <= result.size, "Result count #{result.size} should be larger"
        timestamps = result.map(&:updated_at)
        assert_equal timestamps.sort, timestamps, 'not sorted correctly'
      end
    end

    def test_sort_by_updated_at_desc_works
      search_params = {:sort_by => 'updated_at', :sort_order => 'desc', :limit => 15}
      eventually do
        result = Event.search(:params => search_params).within_limit.to_a
          assert 15 <= result.size, "Result count #{result.size} should be larger"
          timestamps = result.map(&:updated_at)
          assert_equal timestamps.sort.reverse, timestamps, 'not sorted correctly'
      end
    end
  end

end; end
