# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class RoleDeleteTest < ConnectorTestCase

    def test_delete_role_should_be_successful
      # This is needed to not get AWS::DynamoDB::Errors::ConditionalCheckFailedException
      sleep 0.5

      role = Role.create(:name => "Delete#{SecureRandom.hex(4)}_#{iso_time}")
      role_id = role.id
      assert_not_nil role_id

      eventually do
        Role.find(role_id)
      end

      assert_kind_of Net::HTTPOK, role.destroy

      eventually do
        assert_raise ActiveResource::ResourceNotFound do
          Role.find(role_id)
        end
      end
    end

  end

end; end
