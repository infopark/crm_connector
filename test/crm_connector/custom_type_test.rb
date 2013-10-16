# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class CustomTypeTest < ConnectorTestCase

    def self.startup
      # This is needed to not get AWS::DynamoDB::Errors::ConditionalCheckFailedException
      sleep 0.5

      @@name_a = "ct_a_#{iso_time}"
      @@custom_type = CustomType.create(:name => @@name_a, :kind => 'Activity',
          :custom_attributes => [{:name => 'custom_test1', :type => 'string'}])
      @@name_b = "ct_b_#{iso_time}"
      CustomType.create(:name => @@name_b, :kind => 'Activity')
    end


    def test_find_all_returns_all_custom_types
      eventually do
        names = CustomType.find(:all).map(&:name)
        intersection = [@@name_a, @@name_b] & names
        assert_equal [@@name_a, @@name_b], intersection
      end
    end

    def test_find_by_id_with_valid_id_should_return_an_instance
      eventually do
        assert_show_succeeds(CustomType, @@name_a)
      end
    end

    def test_find_by_name_with_invalid_name_raises_an_error
      assert_show_fails(CustomType, 'unsupported bag')
    end

    def test_a_custom_type_should_have_custom_attributes
      eventually do
        type = CustomType.find(@@name_a)
        assert_kind_of Array, type.custom_attributes
        assert_kind_of CustomType::CustomAttribute, type.custom_attributes.first
        assert_equal 'custom_test1', type.custom_attributes.first.name
        assert_equal 'string', type.custom_attributes.first.type
      end
    end

  end

end; end
