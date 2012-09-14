# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm
  class ActivitySearchCustomFieldTest < ConnectorTestCase
    class << self
      def startup
        ca = {:name => 'activity_test', :type => 'string'}
        t = CustomType.create(:name => SecureRandom.hex(10),
            :kind => 'Activity', :custom_attributes => [ca])

        @@now = Time.new.to_i
        Activity.create(:kind => t.name, :title => 'Custom',
            :custom_activity_test => "Master#{@@now}")
        Activity.create(:kind => t.name, :title => "Master#{@@now}",
            :custom_activity_test => 'not master')
        wait_for_indexer
      end
    end

    def test_search_should_with_q_find_custom_field
      result = Activity.search(:params => {:q => "Master#{@@now}"})
      assert_equal 2, result.size
    end

    def test_search_with_custom_field_should_find_custom_field
      result = Activity.search(:params => {:custom_activity_test => "Master#{@@now}"})
      assert_equal 1, result.size
    end
  end
end; end
