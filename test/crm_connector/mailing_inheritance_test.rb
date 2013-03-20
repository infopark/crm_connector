# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class TestInheritanceMailing < Mailing
  end

  class MailingInheritanceTest < ConnectorTestCase
    def test_inheritance_works
      original = Mailing.new()
      assert_nil original.body
      decendent = TestInheritanceMailing.new()
      assert_nil decendent.body
    end
  end

end; end
