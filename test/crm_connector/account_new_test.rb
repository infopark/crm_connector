# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class AccountNewTest < ConnectorTestCase
    def setup
      @account = Account.new
    end

    def test_can_access_static_properties_of_account
      assert_nil @account.account_group
      assert_nil @account.country
      assert_nil @account.extended_address
      assert_nil @account.home_page
      assert_nil @account.locality
      assert_nil @account.name
      assert_nil @account.org_name_address
      assert_nil @account.org_unit_address
      assert_nil @account.phone
      assert_nil @account.postalcode
      assert_nil @account.region
      assert_nil @account.street_address
      assert_nil @account.tags
      assert_nil @account.want_geo_location
    end
  end
end; end
