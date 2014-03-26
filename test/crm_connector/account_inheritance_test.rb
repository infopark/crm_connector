# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class TestInheritanceAccount < Account
  end

  class AccountInheritanceTest < ConnectorTestCase
    def test_inheritance_works
      original = Account.new()
      assert_nil original.name
      decendent = TestInheritanceAccount.new()
      assert_nil decendent.name
    end
  end

end; end
