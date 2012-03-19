# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class MachineReadableErrorsTest < ConnectorTestCase

    def setup
      Infopark::Crm.configure {|c| c.locale = 'de'}
      @invalid_resource = Activity.create({})
      assert !@invalid_resource.valid?
    end

    def teardown
      Infopark::Crm.configure {|c| c.locale = nil}
    end

    def test_errors_are_assigned_to_fields
      assert_equal 'muss ausgefüllt werden', @invalid_resource.errors['title'].try(:first)
    end

  end

end; end
