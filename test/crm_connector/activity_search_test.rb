# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class ActivitySearchTest < ConnectorTestCase
    class << self
      def startup
        CrmSetup.custom_types
        if (Activity.find(:all, :params => {:limit => 15}).within_limit.size < 15)
          15.times do
            Activity.new(:kind => 'support case', :state=>'created', :title => 'A').save!
          end
          wait_for_indexer
        end
      end
    end

    def test_search_should_return_activities
      result = Activity.search(:params => {})
      assert_kind_of Activity, result.first
      assert 9 < result.size, "Result count #{result.size} should be many"
    end

    def test_unsuccessful_search
      result = Activity.search(:params => {:state => "Theresnothinglikethis123"})
      assert_equal 0, result.size
      result = Activity.search(:params => {:q => "Theresnothinglikethis123"})
      assert_equal 0, result.size
    end

    def test_search_should_return_count
      result = Activity.search(:params => {})
      assert 15 <= result.size, "Result count #{result.size} should be larger"
    end

    def test_search_should_return_items_in_continuation
      result = Activity.search(:params => {:q => '', :limit => 10})
      assert_equal result.take(14).size, 14
    end

    def test_sort_by_updated_at_works
      result = Activity.search(:params =>
          {:sort_by => 'updated_at', :limit => 15}).within_limit.to_a
      assert 15 <= result.size, "Result count #{result.size} should be larger"
      timestamps = result.map(&:updated_at)
      assert_equal timestamps.sort, timestamps, 'not sorted correctly'
    end

    def test_sort_by_updated_at_asc_works
      result = Activity.search(:params =>
          {:sort_by => 'updated_at', :sort_order => 'asc', :limit => 15}).within_limit.to_a
      assert 15 <= result.size, "Result count #{result.size} should be larger"
      timestamps = result.map(&:updated_at)
      assert_equal timestamps.sort, timestamps, 'not sorted correctly'
    end

    def test_sort_by_updated_at_desc_works
      result = Activity.search(:params =>
          {:sort_by => 'updated_at', :sort_order => 'desc', :limit => 15}).within_limit.to_a
      assert 15 <= result.size, "Result count #{result.size} should be larger"
      timestamps = result.map(&:updated_at)
      assert_equal timestamps.sort.reverse, timestamps, 'not sorted correctly'
    end

  end

end; end
