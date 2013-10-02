# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class RoleCreateTest < ConnectorTestCase

    def setup
      # This is needed to not get AWS::DynamoDB::Errors::ConditionalCheckFailedException
      sleep 0.5
    end

    def test_create_role_should_be_successful
      assert_create_succeeds(Role, :name => "Role#{SecureRandom.hex(11)}",
          :description => Time.now.utc.xmlschema)
    end

    def test_create_role_with_insufficient_properties_should_fail
      assert_create_fails(Role, :home_page => 'gopher://last_server')
    end

    def test_create_role_by_save_should_be_successful
      assert_create_by_save_succeeds(Role, :name => "OtherRole#{SecureRandom.hex(11)}",
          :description => Time.now.utc.xmlschema)
    end

    def test_create_role_by_save_with_insufficient_properties_should_fail
      assert_create_by_save_fails(Role, :home_page => 'gopher://first_server')
    end

  end

end; end
