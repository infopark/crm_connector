# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class CustomTypeTest < ConnectorTestCase

    def self.startup
      # This is needed to not get AWS::DynamoDB::Errors::ConditionalCheckFailedException
      sleep 0.5

      @@name_a = "ct_a_#{iso_time}"
      CustomType.create(:name => @@name_a, :kind => 'Activity')
      t = CustomType.find(@@name_a)
      t.custom_attributes = [CustomType::CustomAttribute.new(:name => 'custom_test1', :type => 'string')]
      t.save!
      @@custom_type = t
      @@name_b = "ct_b_#{iso_time}"
      CustomType.create(:name => @@name_b, :kind => 'Activity')
      wait_for_indexer
    end


    def test_find_all_returns_all_custom_types
      names = CustomType.find(:all).map(&:name)
      assert [@@name_a, @@name_b] & names == [@@name_a, @@name_b]
    end

    def test_find_by_id_with_valid_id_should_return_an_instance
      assert_kind_of CustomType, ik = CustomType.find(@@name_a)
      assert_equal @@name_a, ik.name
    end

    # @webcrm_todo currently throws (which is correct for an active resource) - change requirements?
    def pending_test_find_by_name_with_invalid_name_should_return_nil
      assert_nil CustomType.find('unsupported bag')
    end

    def test_a_custom_type_should_have_custom_attributes
      type = CustomType.find(@@custom_type.name)
      assert_kind_of Array, type.custom_attributes
      assert_kind_of CustomType::CustomAttribute, type.custom_attributes.first
      assert_equal 'custom_test1', type.custom_attributes.first.name
    end

    def test_custom_attributes_type_is_accessible
      custom_attributes = CustomType.find(@@custom_type.name).custom_attributes
      assert_equal 'string', custom_attributes.first.type
    end

  end

end; end
