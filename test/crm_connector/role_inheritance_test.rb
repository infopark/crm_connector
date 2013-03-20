# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class TestInheritanceRole < Role
  end

  class RoleInheritanceTest < ConnectorTestCase
    def test_inheritance_works
      original = Role.new()
      assert_nil original.description
      decendent = TestInheritanceRole.new()
      assert_nil decendent.description
    end
  end

end; end
