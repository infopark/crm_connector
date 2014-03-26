# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class EventContactSearchTest < ConnectorTestCase
    class << self
      def startup
        CrmSetup.custom_types
        event_attr = {
          :dtstart_at => Time.now,
          :dtend_at => Time.now + 1.day,
          :custom_attributes => [
            { :name => 'breakfast', :type => 'string' },
            { :name => 'lunch', :type => 'string' }
          ],
          :kind => 'base event'
        }
        @@event = Event.create(event_attr.merge(:title => 'Event'))
        other_event = Event.create(event_attr.merge(:title => 'Other Event'))

        contact_attr = {:language => 'de', :gender => 'M', :want_geo_location => false}
        @@contact = Contact.create(contact_attr.merge(:last_name => 'Eisler'))
        other_contact = Contact.create(contact_attr.merge(:last_name => 'Not Eisler'))

        EventContact.create(:contact_id => @@contact.id, :event_id => @@event.id, :state => 'registered')
        EventContact.create(:contact_id => @@contact.id, :event_id => other_event.id, :state => 'registered')
        EventContact.create(:contact_id => other_contact.id, :event_id => @@event.id, :state => 'refused', :custom_breakfast => 'bacon')
      end
    end

    def test_search_should_return_event_contacts
      eventually do
        result = EventContact.search(:params => {})
        assert_kind_of EventContact, result.first
        assert 3 <= result.size, "Result count #{result.size} should be many"
      end
    end

    def test_unsuccessful_search
      eventually do
        result = EventContact.search(:params => {:contact_id => "Theresnothinglikethis123"})
        assert_equal 0, result.size
      end

      eventually do
        result = EventContact.search(:params => {:q => "Theresnothinglikethis123"})
        assert_equal 0, result.size
      end
    end

    def test_search_should_return_count
      eventually do
        result = EventContact.search(:params => {})
        assert 3 <= result.size, "Result count #{result.size} should be larger"
      end
    end

    def test_search_should_return_items_in_continuation
      eventually do
        result = EventContact.search(:params => {:q => '', :limit => 2})
        size = result.take(3).size
        assert 3 <= size, "Result count #{size} should be larger"
      end
    end

    def test_search_for_contact_id
      eventually do
        result = EventContact.search(:params => {:contact_id => @@contact.id})
        assert_equal 2, result.size
      end
    end

    def test_search_for_event_id
      eventually do
        result = EventContact.search(:params => {:event_id => @@event.id})
        assert_equal 2, result.size
      end
    end

    def test_search_for_state
      eventually do
        result = EventContact.search(:params => {:state => 'registered'})
        not_registered = result.select{ |item| item.state != 'registered'}
        assert_equal 0, not_registered.size
      end
    end

    def test_search_for_q
      eventually do
        result = EventContact.search(:params => {:event_id => @@event.id, :q => 'bacon'})
        assert_equal 1, result.size
      end
    end

    def test_sort_by_updated_at_works
      search_params = {:sort_by => 'updated_at', :limit => 15}
      eventually do
        result = EventContact.search(:params => search_params).within_limit.to_a
        assert 3 <= result.size, "Result count #{result.size} should be larger"
        timestamps = result.map(&:updated_at)
        assert_equal timestamps.sort, timestamps, 'not sorted correctly'
      end
    end

    def test_sort_by_updated_at_asc_works
      search_params = {:sort_by => 'updated_at', :sort_order => 'asc'}
      eventually do
        result = EventContact.search(:params => search_params).within_limit.to_a
        assert 3 <= result.size, "Result count #{result.size} should be larger"
        timestamps = result.map(&:updated_at)
        assert_equal timestamps.sort, timestamps, 'not sorted correctly'
      end
    end

    def test_sort_by_updated_at_desc_works
      search_params = {:sort_by => 'updated_at', :sort_order => 'desc'}
      eventually do
        result = EventContact.search(:params => search_params).within_limit.to_a
        assert 3 <= result.size, "Result count #{result.size} should be larger"
        timestamps = result.map(&:updated_at)
        assert_equal timestamps.sort.reverse, timestamps, 'not sorted correctly'
      end
    end

  end

end; end
