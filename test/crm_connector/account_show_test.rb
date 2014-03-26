# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class AccountShowTest < ConnectorTestCase

    class << self
      def startup
        a = Account.new(:name => 'Infopark AG', :want_geo_location => false)
        a.save!
        @@existing_id = a.id
      end
    end

    def test_find_account_should_return_account
      account = assert_show_succeeds(Account, @@existing_id)
      assert_property(account, :name, 'Infopark AG')
    end

    def test_find_account_with_nonexisting_id_should_fail
      assert_show_fails(Account, 9999)
    end

    def test_find_account_with_null_should_fail
      assert_show_fails(Account, nil)
    end
  end

end; end
