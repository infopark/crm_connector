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
      result = Activity.search(:params => {:q => ''})
      size = result.map{}.size
      assert 15 <= size, "Result count #{size} should be larger"
    end
  end

end; end
