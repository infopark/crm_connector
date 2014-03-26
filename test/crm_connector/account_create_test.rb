# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class AccountCreateTest < ConnectorTestCase

    def test_create_account_should_be_successful
      assert_create_succeeds(Account, :name => 'new account')
    end

    def test_create_account_with_insufficient_properties_should_fail
      assert_create_fails(Account, :home_page => 'gopher://last_server')
    end

    def test_create_account_by_save_should_be_successful
      assert_create_by_save_succeeds(Account, :name => 'yet another new account')
    end

    def test_create_account_by_save_with_insufficient_properties_should_fail
      assert_create_by_save_fails(Account, :home_page => 'gopher://first_server')
    end

  end

end; end
