# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class TestInheritanceActivity < Activity
  end

  class ActivityInheritanceTest < ConnectorTestCase
    def test_inheritance_works
      original = Activity.new()
      assert_nil original.email_cc
      decendent = TestInheritanceActivity.new()
      assert_nil decendent.email_cc
    end
  end

end; end
