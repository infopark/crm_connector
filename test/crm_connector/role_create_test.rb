# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class RoleCreateTest < ConnectorTestCase

    def test_create_role_should_be_successful
      time = Time.now.to_f.to_s.gsub('.', '')
      assert_create_succeeds(Role, :name => "Role#{time}")
    end

    def test_create_role_with_insufficient_properties_should_fail
      assert_create_fails(Role, :home_page => 'gopher://last_server')
    end

    def test_create_role_by_save_should_be_successful
      time = Time.now.to_f.to_s.gsub('.', '')
      assert_create_by_save_succeeds(Role, :name => "OtherRole#{time}")
    end

    def test_create_role_by_save_with_insufficient_properties_should_fail
      assert_create_by_save_fails(Role, :home_page => 'gopher://first_server')
    end

  end

end; end
