# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm
  class EventSearchCustomFieldTest < ConnectorTestCase
    class << self
      def startup
        ca = {:name => 'event_test', :type => 'string'}
        t = CustomType.create(:name => SecureRandom.hex(10),
            :kind => 'Event', :custom_attributes => [ca])

        @@now = Time.new.to_i
        e = Event.create(:kind => t.name, :dtstart_at => Time.now, :dtend_at => Time.now,
            :title => 'Custom', :custom_event_test => "Master#{@@now}")
        Event.create(:kind => t.name, :dtstart_at => Time.now, :dtend_at => Time.now,
            :title => "Master#{@@now}", :custom_event_test => 'not master')
        wait_for_indexer
      end
    end

    def test_search_should_with_q_find_custom_field
      result = Event.search(:params => {:q => "Master#{@@now}"})
      assert_equal 2, result.size
    end

    def test_search_with_custom_field_should_find_custom_field
      result = Event.search(:params => {:custom_event_test => "Master#{@@now}"})
      assert_equal 1, result.size
    end
  end
end; end
