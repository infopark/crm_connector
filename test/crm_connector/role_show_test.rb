# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class RoleShowTest < ConnectorTestCase

    class << self
      def startup
        time = Time.now.to_f.to_s.gsub('.', '')
        role = Role.create(:name => "ShowRole#{time}", :description => 'Hello World')

        @@existing_id = role.id
      end
    end

    def test_find_role_should_return_role
      role = assert_show_succeeds(Role, @@existing_id)
      assert_property(role, :description, 'Hello World')
    end

    def test_find_role_with_nonexisting_id_should_fail
      assert_show_fails(Role, 9999)
    end

    def test_find_role_with_null_should_fail
      assert_show_fails(Role, nil)
    end
  end

end; end
