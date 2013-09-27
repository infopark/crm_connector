# encoding: utf-8

require 'backports'
require_relative '../test_helper'


module Infopark; module Crm

  class ContinuationTest < ConnectorTestCase
    def self.startup
      @@activity_size = Activity.search(:params => {}).size
    end

    def test_search_activities_gives_enum
      assert_kind_of Enumerable, Activity.search(:params => {})
    end

    def test_find_all_activities_gives_enum
      assert_kind_of Enumerable, Activity.all
    end

    def test_find_all_activities_gives_results
      all = Activity.find(:all, :params => {:limit => (@@activity_size + 2)/3})
      result = all.reject {|a| a.kind_of? Activity}
      assert_equal 0, result.size
    end

    def test_search_activities_gives_results
      all = Activity.search(:params => {:limit => (@@activity_size + 2)/3})
      result = all.reject {|a| a.kind_of? Activity}
      assert_equal 0, result.size
    end

    class TestActivity < Activity; end
    def test_iterating_within_limits_makes_no_2nd_request
      $test_request_count = 0
      def TestActivity.connection
        $test_request_count += 1
        super
      end
      result = TestActivity.find(:all, :params => {:limit => 2})
      result.next
      assert_equal 1, $test_request_count
      result.next
      assert_equal 1, $test_request_count unless RUBY_VERSION.start_with? "1.8"
      result.next
      assert_equal 2, $test_request_count
    end

    def test_access_without_auto_continuation
      result = Contact.all
      assert_kind_of ActiveResource::Collection, result.within_limit
      assert_not_nil result.continuation_handle
      assert_kind_of Contact, result.within_limit.last
    end

    def test_minimal_inspection_is_available
      result = Contact.all.inspect
      assert result.include? "Contact"
      assert result.include? "within_limit"
      assert result.include? "continuation_handle"
    end
  end

end; end
