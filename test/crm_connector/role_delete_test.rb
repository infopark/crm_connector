# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class RoleDeleteTest < ConnectorTestCase

    def test_delete_role_should_be_successful
      # This is needed to not get AWS::DynamoDB::Errors::ConditionalCheckFailedException
      sleep 0.5

      time = Time.now.to_f.to_s.gsub('.', '')
      role = Role.create(:name => "DeleteRole#{time}")
      assert_not_nil role.id

      assert_kind_of Net::HTTPOK, role.destroy
      assert_raise ActiveResource::ResourceNotFound do
        Role.find(role.id)
      end
    end

  end

end; end
