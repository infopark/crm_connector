# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class RoleShowTest < ConnectorTestCase
    def test_find_role_should_return_role
      # This is needed to not get AWS::DynamoDB::Errors::ConditionalCheckFailedException
      sleep 0.5

      role = Role.create(:name => "Show#{SecureRandom.hex(4)}_#{iso_time}",
          :description => 'Hello World')

      role = assert_show_succeeds(Role, role.id)
      assert_property(role, :description, 'Hello World')
    end

    def test_find_role_with_nonexisting_id_should_fail
      assert_show_fails(Role, 9999)
    end
  end

end; end
