# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class TestInheritanceEvent < Event
  end

  class EventInheritanceTest < ConnectorTestCase
    def test_inheritance_works
      original = Event.new()
      assert_nil original.location
      decendent = TestInheritanceEvent.new()
      assert_nil decendent.location
    end
  end

end; end
