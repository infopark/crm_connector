# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class RoleShowTest < ConnectorTestCase
    def test_find_role_should_return_role
      # This is needed to not get AWS::DynamoDB::Errors::ConditionalCheckFailedException
      sleep 0.5

      role = Role.create(:name => "ShowRole#{SecureRandom.hex(8)}",
          :description => Time.now.utc.xmlschema + ' Hello World')

      role = assert_show_succeeds(Role, role.id)
      assert_match(/Hello World/, role.description)
    end

    def test_find_role_with_nonexisting_id_should_fail
      assert_show_fails(Role, 9999)
    end

    def test_find_role_with_null_should_fail
      assert_show_fails(Role, nil)
    end
  end

end; end
