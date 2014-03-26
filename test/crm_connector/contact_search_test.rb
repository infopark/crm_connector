# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class ContactSearchTest < ConnectorTestCase
    class << self
      def startup
        if (Contact.find(:all, :params => {:limit => 15}).within_limit.size < 15)
          15.times do
            Contact.create(:first_name => 'Alfred', :last_name => 'Search', :gender=> 'M', :language => 'en')
          end
        end
        Contact.create(:first_name => 'Alfred', :last_name => 'Search', :gender=> 'M', :language => 'en')
        Contact.create(:first_name => 'Jon', :last_name => 'Email', :gender=> 'F', :language => 'en',
            :login => 'klammeraffe@example.com')
        @@contact = Contact.create(:last_name => 'Search with Login', :gender=> 'M',
            :language => 'en', :login => SecureRandom.hex(16))
      end
    end

    def test_search_should_return_contacts
      eventually do
        result = Contact.search(:params => {})
        assert 9 < result.size, "Result count #{result.size} should be many"
        assert_kind_of Contact, result.first
      end
    end

    def test_search_should_find_by_login
      eventually do
        result = Contact.search(:params => {:login => @@contact.login})
        assert_equal 1, result.size
      end
    end

    def test_unsuccessful_search
      eventually do
        result = Contact.search(:params => {:login => "Theresnothinglikethis123"})
        assert_equal 0, result.size
      end
      eventually do
        result = Contact.search(:params => {:q => "Theresnothinglikethis123"})
        assert_equal 0, result.size
      end
    end

    def test_search_should_return_items_in_continuation
      eventually do
        result = Contact.search(:params => {:q => '', :limit => 10})
        assert_equal 14, result.take(14).size
      end
    end

    def test_search_by_q_should_be_sucessful
      eventually do
        result = Contact.search(:params => {:q => 'Email'})
        assert 1 <= result.size, "Result count #{result.size} should be many"
        names = result.map(&:last_name)
        assert !names.include?('Search'), "Result should not contain object with last_name 'Search'"
      end

      eventually do
        result = Contact.search(:params => {:q => 'Alfred'})
        assert 1 <= result.size, "Result count #{result.size} should be many"
        names = result.map(&:first_name)
        assert !names.include?('Jon'), "Result should not contain object with first_name 'Jon'"
      end
    end

    def test_search_should_return_count
      eventually do
        result = Contact.search(:params => {})
        assert 15 < result.size, "Result count #{result.size} should be larger"
      end
    end

    def test_search_by_login_with_special_character
      eventually do
        assert_equal 1, Contact.search(:params => {:login => 'klammeraffe@example.com'}).size
      end
      eventually do
        assert_equal 0, Contact.search(:params => {:login => 'klammeraffe'}).size
      end
    end

    def test_sort_by_updated_at_works
      search_params = {:sort_by => 'updated_at', :limit => 15}
      eventually do
        result = Contact.search(:params => search_params).within_limit.to_a
        assert 15 <= result.size, "Result count #{result.size} should be larger"
        timestamps = result.map(&:updated_at)
        assert_equal timestamps.sort, timestamps, 'not sorted correctly'
      end
    end

    def test_sort_by_updated_at_asc_works
      search_params = {:sort_by => 'updated_at', :sort_order => 'asc', :limit => 15}
      eventually do
        result = Contact.search(:params => search_params).within_limit.to_a
        assert 15 <= result.size, "Result count #{result.size} should be larger"
        timestamps = result.map(&:updated_at)
        assert_equal timestamps.sort, timestamps, 'not sorted correctly'
      end
    end

    def test_sort_by_updated_at_desc_works
      search_params = {:sort_by => 'updated_at', :sort_order => 'desc', :limit => 15}
      eventually do
        result = Contact.search(:params => search_params).within_limit.to_a
        assert 15 <= result.size, "Result count #{result.size} should be larger"
        timestamps = result.map(&:updated_at)
        assert_equal timestamps.sort.reverse, timestamps, 'not sorted correctly'
      end
    end

  end

end; end
