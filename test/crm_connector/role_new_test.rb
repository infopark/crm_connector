# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class RoleNewTest < ConnectorTestCase
    def test_can_access_static_properties_of_role
      @role = Role.new

      assert_nil @role.description
      assert_nil @role.name
      assert_nil @role.permissions
    end
  end
end; end
