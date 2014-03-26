# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class AccountDeleteTest < ConnectorTestCase

    def test_delete_account_should_be_successful
      account = Account.create(:name => 'Delete AG')
      assert_not_nil account.id
      assert_nil account.deleted_at

      assert_kind_of Net::HTTPOK, account.destroy
      assert_not_nil Account.find(account.id).deleted_at
    end

  end

end; end
