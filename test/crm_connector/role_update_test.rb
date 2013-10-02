# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class RoleUpdateTest < ConnectorTestCase

    def self.startup
      # This is needed to not get AWS::DynamoDB::Errors::ConditionalCheckFailedException
      sleep 0.5

      @@role = Role.create(:name => "Update#{SecureRandom.hex(8)}",
          :description => Time.now.utc.xmlschema + ' Hello World')
    end

    def test_updating_a_role_should_be_successful
      assert_update_succeeds(@@role, :description => Time.now.utc.xmlschema + ' Hello Universe')
      assert_match(/Hello Universe/, Role.find(@@role.id).description)
    end

    def test_updating_a_role_by_save_should_be_successful
      assert_update_by_save_succeeds(@@role,
          :description => Time.now.utc.xmlschema + ' Hello Meta Universe')
      assert_match(/Hello Meta Universe/, Role.find(@@role.id).description)
    end
  end

end; end
