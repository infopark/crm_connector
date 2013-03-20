# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class TestInheritanceContact < Contact
  end

  class ContactInheritanceTest < ConnectorTestCase
    def test_inheritance_works
      original = Contact.new()
      assert_nil original.last_name
      decendent = TestInheritanceContact.new()
      assert_nil decendent.last_name
    end
  end

end; end
