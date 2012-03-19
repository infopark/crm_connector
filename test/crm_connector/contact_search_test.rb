# encoding: utf-8

require 'backports'
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
        Contact.create(:first_name => 'Jon', :last_name => 'Email', :gender=> 'F', :language => 'en',
            :login => 'klammeraffe@example.com')
        @@contact = Contact.create(:last_name => 'Search with Login', :gender=> 'M',
            :language => 'en', :login => SecureRandom.hex(16))
        wait_for_indexer
      end
    end

    def test_search_should_return_contacts
      result = Contact.search(:params => {})
      assert 9 < result.size, "Result count #{result.size} should be many"
      assert_kind_of Contact, result.first
    end

    def test_search_should_find_by_login
      result = Contact.search(:params => {:login => @@contact.login})
      assert_equal 1, result.size
    end

    def test_unsuccessful_search
      result = Contact.search(:params => {:login => "Theresnothinglikethis123"})
      assert_equal 0, result.size
      result = Contact.search(:params => {:q => "Theresnothinglikethis123"})
      assert_equal 0, result.size
    end

    def test_search_by_q_should_be_sucessful
      result = Contact.search(:params => {:q => 'Email'})
      assert 1 <= result.size, "Result count #{result.size} should be many"
      names = result.map(&:last_name)
      assert !names.include?('Search'), "Result should not contain object with last_name 'Search'"

      result = Contact.search(:params => {:q => 'Alfred'})
      assert 1 <= result.size, "Result count #{result.size} should be many"
      names = result.map(&:first_name)
      assert !names.include?('Jon'), "Result should not contain object with first_name 'Jon'"
    end

    def test_search_should_return_count
      result = Contact.search(:params => {})
      assert 15 < result.size, "Result count #{result.size} should be larger"
    end

    def test_search_by_login_with_special_character
      assert_equal 1, Contact.search(:params => {:login => 'klammeraffe@example.com'}).size
      assert_equal 0, Contact.search(:params => {:login => 'klammeraffe'}).size
    end

  end

end; end
