# encoding: utf-8

require 'backports'
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
        @@account_group_name = "Subdevision Inc. #{Time.new.to_i}"
        Account.create(:name => @@account_group_name, :account_group => 'SomeAccountName')

        wait_for_indexer
      end
    end

    def test_search_should_return_accounts
      result = Account.search(:params => {})
      assert 9 < result.size, "Result count #{result.size} should be many"
      assert_kind_of Account, result.first
    end

    def test_search_should_find_by_q
      result = Account.search(:params => {:q => @@account_group_name})
      assert_equal 1, result.size
    end

    def test_search_should_find_by_account_group
      result = Account.search(:params => {:account_group => 'SomeAccountName'})
      assert 1 <= result.size
    end

    def test_unsuccessful_search
      result = Account.search(:params => {:account_group => "Theresnothinglikethis123"})
      assert_equal 0, result.size
      result = Account.search(:params => {:q => "Theresnothinglikethis123"})
      assert_equal 0, result.size
    end

    def test_search_should_return_count
      result = Account.search(:params => {})
      assert 15 < result.size, "Result count #{result.size} should be larger"
    end

    def test_sort_by_updated_at_works
      result = Account.search(:params =>
          {:sort_by => 'updated_at', :limit => 15}).within_limit.to_a
      assert 15 <= result.size, "Result count #{size} should be larger"

      correct = result.each_cons(2).reduce(true) do |correct, (first, second)|
        correct && (DateTime.parse(first.updated_at.to_s) <= DateTime.parse(second.updated_at.to_s))
      end
      assert_true correct, 'not sorted correctly'
    end

    def test_sort_by_updated_at_asc_works
      result = Account.search(:params =>
          {:sort_by => 'updated_at', :sort_order => 'asc', :limit => 15}).within_limit.to_a
      assert 15 <= result.size, "Result count #{size} should be larger"

      correct = result.each_cons(2).reduce(true) do |correct, (first, second)|
        correct && (DateTime.parse(first.updated_at.to_s) <= DateTime.parse(second.updated_at.to_s))
      end
      assert_true correct, 'not sorted correctly'
    end

    def test_sort_by_updated_at_desc_works
      result = Account.search(:params =>
        {:sort_by => 'updated_at', :sort_order => 'desc', :limit => 15}).within_limit.to_a
      assert 15 <= result.size, "Result count #{size} should be larger"

      correct = result.each_cons(2).reduce(true) do |correct, (first, second)|
        correct && (DateTime.parse(first.updated_at.to_s) >= DateTime.parse(second.updated_at.to_s))
      end
      assert_true correct, 'not sorted correctly'
    end
  end

end; end
