# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class ContactNewTest < ConnectorTestCase
    def setup
      @contact = Contact.new
    end

    def test_can_access_static_properties_of_contact
      assert_nil @contact.account_id
      assert_nil @contact.country
      assert_nil @contact.email
      assert_nil @contact.extended_address
      assert_nil @contact.fax
      assert_nil @contact.first_name
      assert_nil @contact.gender
      assert_nil @contact.job_title
      assert_nil @contact.language
      assert_nil @contact.last_name
      assert_nil @contact.locality
      assert_nil @contact.login
      assert_nil @contact.mobile_phone
      assert_nil @contact.name_prefix
      assert_nil @contact.org_name_address
      assert_nil @contact.org_unit_address
      assert_nil @contact.phone
      assert_nil @contact.postalcode
      assert_nil @contact.region
      assert_nil @contact.role_names
      assert_nil @contact.street_address
      assert_nil @contact.tags
      assert_nil @contact.want_email
      assert_nil @contact.want_geo_location
      assert_nil @contact.want_phonecall
      assert_nil @contact.want_snailmail
    end

    def test_can_access_unknown_custom_properties_of_contact
      assert_nil @contact.custom_some_test
      assert_nil @contact.custom_will_be_defined_in_the_distant_future
    end
  end
end; end
