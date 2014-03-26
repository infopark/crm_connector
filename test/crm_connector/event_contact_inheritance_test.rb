# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class TestInheritanceEventContact < EventContact
  end

  class EventContactInheritanceTest < ConnectorTestCase
    def test_inheritance_works
      original = EventContact.new()
      assert_nil original.contact_id
      decendent = TestInheritanceEventContact.new()
      assert_nil decendent.contact_id
    end
  end

end; end
