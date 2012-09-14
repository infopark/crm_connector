# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class ActivityCustomAttributesTest < ConnectorTestCase
    def self.startup
      CrmSetup.custom_types
    end

    def test_activity_with_valid_kind_returns_nil_for_uninitialized_custom_attribute_value
      # text
      assert_equal nil, Activity.new(:kind => 'support case').custom_agent
      # enum (also single valued ...)
      assert_equal nil, Activity.new(:kind => 'support case').custom_priority
    end

    def test_activity_without_kind_raises_no_method_for_unknown_property
      assert_raise NoMethodError do
        Activity.new.undefined_property
      end
    end

    def test_activity_without_kind_for_unknown_custom_property
      assert_nil Activity.new.custom_undefined_property
    end

  end
end; end
