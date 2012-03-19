# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class MailingSearchTest < ConnectorTestCase
    class << self
      def startup
        if (Mailing.find(:all, :params => {:limit => 15}).within_limit.size < 15)
          15.times do
            Mailing.create(:title => 'Search Mailing', :mailing_type => 'i')
          end
        end

        @@unique_mailing_title = "Mailing Nr. #{Time.new.to_i}"
        Mailing.create(:title => @@unique_mailing_title, :mailing_type => 'i')

        CrmSetup.custom_types
        e = Event.create(:title => 'A search me Event',
            :dtstart_at => Time.now,
            :dtend_at => Time.now + 1.day,
            :details => 'breakfast, lunch',
            :kind => 'base event')
        @@event_id = e.id
        Mailing.create(:title => 'Search Event', :mailing_type => 'i', :event_id => @@event_id)

        wait_for_indexer
      end
    end

    def test_search_should_return_mailings
      result = Mailing.search(:params => {})
      assert 9 < result.size, "Result count #{result.size} should be many"
      assert_kind_of Mailing, result.first
    end

    def test_search_should_find_by_q
      result = Mailing.search(:params => {:q => @@unique_mailing_title})
      assert_equal 1, result.size
    end

    def test_search_should_find_by_event_id
      result = Mailing.search(:params => {:event_id => @@event_id})
      assert 1 <= result.size
      result.each do |mailing|
        assert_equal @@event_id, mailing.event_id
      end
    end

    def test_unsuccessful_search
      result = Mailing.search(:params => {:event_id => "Theresnothinglikethis123"})
      assert_equal 0, result.size
      result = Mailing.search(:params => {:q => "Theresnothinglikethis123"})
      assert_equal 0, result.size
    end

    def test_search_should_return_count
      result = Mailing.search(:params => {})
      assert 15 < result.size, "Result count #{result.size} should be larger"
    end

  end

end; end
