# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class AccountUpdateTest < ConnectorTestCase
    def setup
      @account = Account.create(:name => "Account #{SecureRandom.hex(8)}")
    end

    def test_updating_an_account_should_be_successful
      assert_update_succeeds(@account, :home_page => 'https://secure.infopark.de')
      assert_equal 'https://secure.infopark.de',
          Account.find(@account.id).home_page
    end

    def test_invalid_updating_an_account_should_fail
      assert_update_fails(@account, :name => '')
      assert_validation_failed(@account, /Name can't be blank|Name muss ausgefüllt werden/)
    end

    def test_updating_an_account_by_save_should_be_successful
      assert_update_by_save_succeeds(@account, :home_page => 'http://www.infopark.de')
      assert_equal 'http://www.infopark.de',
          Account.find(@account.id).home_page
    end

    def test_invalid_updating_an_account_by_save_should_fail
      assert_update_by_save_fails(@account, :name => '')
      assert_validation_failed(@account, /Name can't be blank|Name muss ausgefüllt werden/)
    end
  end

end; end
