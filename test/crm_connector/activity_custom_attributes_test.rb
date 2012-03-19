# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class ActivityCustomAttributesTest < ConnectorTestCase
    def setup
      CrmSetup.custom_types
      @new_support_case = Activity.new(:kind => 'support case')
      @new_kindless_activity = Activity.new
    end

    def test_activity_with_valid_kind_returns_nil_for_uninitialized_custom_attribute_value
      # text
      assert_equal nil, @new_support_case.custom_agent
      # enum (also single valued ...)
      assert_equal nil, @new_support_case.custom_priority
    end

    def test_activity_without_kind_raises_no_method_for_unknown_property
      assert_raise NoMethodError do
        @new_kindless_activity.undefined_property
      end
    end

    def test_activity_without_kind_for_unknown_custom_property
      assert_nil @new_kindless_activity.custom_undefined_property
    end

  end
end; end
