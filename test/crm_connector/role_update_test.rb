# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class RoleUpdateTest < ConnectorTestCase

    def self.startup
      # This is needed to not get AWS::DynamoDB::Errors::ConditionalCheckFailedException
      sleep 0.5

      @@role = Role.create(:name => "Update#{SecureRandom.hex(4)}_#{iso_time}",
          :description => 'Hello World')
    end

    def test_updating_a_role_should_be_successful
      eventually do
        assert_update_succeeds(@@role, :description => 'Hello Universe')
      end
      eventually do
        assert_equal 'Hello Universe', Role.find(@@role.id).description
      end
    end

    def test_updating_a_role_by_save_should_be_successful
      eventually do
        assert_update_by_save_succeeds(@@role, :description => 'Hello Meta Universe')
      end
      eventually do
        assert_equal 'Hello Meta Universe', Role.find(@@role.id).description
      end
    end
  end

end; end
