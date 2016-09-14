# encoding: utf-8
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

    def test_iterating_within_limits_makes_no_2nd_request
      WebMock.enable!
      WebMock.allow_net_connect!
      WebMock.reset!
      Activity.find(:all, :params => {:limit => 2}).take(3)
      assert_requested(:get, "#{Activity.site}activities.json", query: hash_including(limit: '2'), times: 2)
    ensure
      WebMock.disable!
    end

    def test_access_without_auto_continuation
      result = Contact.all
      assert_kind_of Array, result.within_limit
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
