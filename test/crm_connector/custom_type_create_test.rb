# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class CustomTypeNewTest < ConnectorTestCase
    def teardown
      WebMock.disable!
    end

    def test_create_should_be_successful
      t = CustomType.create(:name => SecureRandom.hex(10), :kind => 'Activity')
      assert_created(t)
    end

    def test_create_by_save_should_be_successful
      t = CustomType.new(:name => SecureRandom.hex(10), :kind => 'Activity')
      t.save
      assert_created(t)
    end

    def test_create_should_accept_custom_attribute_as_hash
      ca = {:name => 'custom_x', :type => 'string'}
      t = CustomType.create(:name => SecureRandom.hex(10), :kind => 'Activity', :custom_attributes => [ca])
      assert_created(t)
    end

    def test_create_should_accept_custom_attribute_as_object
      ca = CustomType::CustomAttribute.new(:name => 'custom_x', :type => 'string')
      t = CustomType.create(:name => SecureRandom.hex(10), :kind => 'Activity', :custom_attributes => [ca])
      assert_created(t)
    end

    def test_create_by_save_should_accept_mixed_attributes_as_object
      ca1 = {:name => 'custom_x', :type => 'string'}
      ca2 = CustomType::CustomAttribute.new(:name => 'custom_y', :type => 'string')
      t = CustomType.new(:name => SecureRandom.hex(10), :kind => 'Event', :custom_attributes => [ca1])
      t.custom_attributes += [ca2]
      t.save
      assert_created(t)
    end

    def test_correct_webservice_request
      WebMock.enable!
      stub_request(:post, %r{http://.*/api/custom_types.json}).
        with(:body => {
            "custom_type" => {
              "custom_attributes" => [{"name" => "custom_y", "type" => "string"}],
              "kind" => "Activity",
              "name" => "some_stubbed_name"
            }})

      ca = {:name => 'custom_y', :type => 'string'}
      t = CustomType.create(:name => "some_stubbed_name", :kind => 'Activity', :custom_attributes => [ca])
    end
  end

end; end
