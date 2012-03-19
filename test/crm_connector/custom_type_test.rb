# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class CustomTypeTest < ConnectorTestCase

    class << self
      def startup
        CustomType.create(:name => 'test_ct_a', :kind => 'Activity') unless CustomType.exists? 'test_ct_a'
        t = CustomType.find 'test_ct_a'
        t.custom_attributes = [CustomType::CustomAttribute.new(:name => 'custom_test1', :type => 'string')]
        t.save!
        @@custom_type = t
        CustomType.create(:name => 'test_ct_b', :kind => 'Activity') unless CustomType.exists? 'test_ct_b'
      end
    end


    def test_find_all_returns_all_custom_types
      names = CustomType.find(:all).map(&:name)
      names.select!{|x| x =~ /test_ct/}
      assert_equal ['test_ct_a', 'test_ct_b'], names
    end

    def test_find_by_id_with_valid_id_should_return_an_instance
      assert_kind_of CustomType, ik = CustomType.find('test_ct_a')
      assert_equal 'test_ct_a', ik.name
    end

    # TBD currently throws (which is correct for an active resource) - change requirements?
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
