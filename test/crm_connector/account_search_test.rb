# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class AccountSearchTest < ConnectorTestCase
    class << self
      def startup
        if (Account.find(:all, :params => {:limit => 15}).within_limit.size < 15)
          15.times do
            Account.create(:name => 'Search')
          end
        end
        @@account_group_name = "Subdivision Inc. #{SecureRandom.hex(8)}"
        Account.create(:name => @@account_group_name, :account_group => 'SomeAccountName')
      end
    end

    def test_search_should_return_accounts
      eventually do
        result = Account.search(:params => {})
        assert 9 < result.size, "Result count #{result.size} should be many"
        assert_kind_of Account, result.first
      end
    end

    def test_search_should_find_by_q
      eventually do
        result = Account.search(:params => {:q => @@account_group_name})
        assert_equal 1, result.size
      end
    end

    def test_search_should_find_by_account_group
      eventually do
        result = Account.search(:params => {:account_group => 'SomeAccountName'})
        assert 1 <= result.size
      end
    end

    def test_unsuccessful_search
      eventually do
        result = Account.search(:params => {:account_group => "Theresnothinglikethis123"})
        assert_equal 0, result.size
      end
      eventually do
        result = Account.search(:params => {:q => "Theresnothinglikethis123"})
        assert_equal 0, result.size
      end
    end

    def test_search_should_return_count
      eventually do
        result = Account.search(:params => {})
        assert 15 < result.size, "Result count #{result.size} should be larger"
      end
    end

    def test_sort_by_updated_at_works
      search_params = {:sort_by => 'updated_at', :limit => 15}
      eventually do
        result = Account.search(:params => search_params).within_limit.to_a
        assert 15 <= result.size, "Result count #{result.size} should be larger"
        timestamps = result.map(&:updated_at)
        assert_equal timestamps.sort, timestamps, 'not sorted correctly'
      end
    end

    def test_sort_by_updated_at_asc_works
      search_params = {:sort_by => 'updated_at', :sort_order => 'asc', :limit => 15}
      eventually do
        result = Account.search(:params => search_params).within_limit.to_a
        assert 15 <= result.size, "Result count #{result.size} should be larger"
        timestamps = result.map(&:updated_at)
        assert_equal timestamps.sort, timestamps, 'not sorted correctly'
      end
    end

    def test_sort_by_updated_at_desc_works
      search_params = {:sort_by => 'updated_at', :sort_order => 'desc', :limit => 15}
      eventually do
        result = Account.search(:params => search_params).within_limit.to_a
        assert 15 <= result.size, "Result count #{result.size} should be larger"
        timestamps = result.map(&:updated_at)
        assert_equal timestamps.sort.reverse, timestamps, 'not sorted correctly'
      end
    end
  end

end; end
