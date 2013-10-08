# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm
  class EventSearchCustomFieldTest < ConnectorTestCase
    class << self
      def startup
        ca = {:name => 'event_test', :type => 'string'}
        t = CustomType.create(:name => "#{SecureRandom.hex(2)}_#{iso_time}",
            :kind => 'Event', :custom_attributes => [ca])

        @@unique_value = "Master#{SecureRandom.hex(8)}"
        Event.create(:kind => t.name, :dtstart_at => Time.now, :dtend_at => Time.now,
            :title => 'Custom', :custom_event_test => @@unique_value)
        Event.create(:kind => t.name, :dtstart_at => Time.now, :dtend_at => Time.now,
            :title => @@unique_value, :custom_event_test => 'not master')
        wait_for_indexer
      end
    end

    def test_search_should_with_q_find_custom_field
      result = Event.search(:params => {:q => @@unique_value})
      assert_equal 2, result.size
    end

    def test_search_with_custom_field_should_find_custom_field
      result = Event.search(:params => {:custom_event_test => @@unique_value})
      assert_equal 1, result.size
    end
  end
end; end
