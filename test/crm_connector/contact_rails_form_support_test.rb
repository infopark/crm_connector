# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class ContactRailsFormSupportTest < ConnectorTestCase

    def test_new_contact_should_support_fields_for_account
      c = Contact.new(:last_name => 'olsen', :account_attributes => {:name => 'Olsenbande'})
      assert_kind_of(Account, c.account)
      assert_equal('Olsenbande', c.account.name)
    end

    def test_new_contact_should_support_fields_for_account_with_string_keys
      c = Contact.new(:last_name => 'olsen', "account_attributes" => {:name => 'Olsenbande'})
      assert_kind_of(Account, c.account)
      assert_equal('Olsenbande', c.account.name)
    end

    def test_existing_contact_should_support_fields_for_account
      c = contacts['modifiable']
      assert c.update_attributes(:last_name => 'Olsen', :account_attributes => {:name => 'Olsenbande'})

      assert_equal('Olsenbande', c.account.name)
    end

    def test_existing_contact_should_support_fields_for_account_with_string_keys
      c = contacts['modifiable']
      assert c.update_attributes(:last_name => 'Olsen', "account_attributes" => {:name => 'Olsenbande'})
      assert_equal('Olsenbande', c.account.name)
    end

    def test_new_contact_should_support_fields_for_location
      c = Contact.new(:last_name => 'olsen', :location_attributes => {:city => 'Odense'})
      assert_kind_of(Location, c.location)
      # this is how it is expected from fields_for
      assert_equal('Odense', c.location.city)
    end

    def test_new_contact_should_support_fields_for_location_with_string_keys
      c = Contact.new(:last_name => 'olsen', "location_attributes" => {:city => 'Odense'})
      assert_kind_of(Location, c.location)
      # this is how it is expected from fields_for
      assert_equal('Odense', c.location.city)
    end

    def test_existing_contact_should_support_fields_for_location
      c = contacts['modifiable']
      c.update_attributes(:last_name => '', :location_attributes => {:city => 'Odense'})
      assert_equal('Odense', c.location.city)
    end

    def test_existing_contact_should_support_fields_for_location_with_string_keys
      c = contacts['modifiable']
      c.update_attributes(:last_name => '', "location_attributes" => {:city => 'Odense'})
      assert_equal('Odense', c.location.city)
    end

    def test_account_attributes_should_be_loaded_on_demand
      c = contacts['modifiable']
      attrs = c.account_attributes.attributes
      assert_equal(attrs, c.account.attributes)
    end

    def test_location_attributes_should_be_loaded_on_demand
      c = contacts['modifiable']
      attrs = c.location_attributes.attributes
      assert_equal(attrs, c.location.attributes)
    end

    def test_setting_or_loading_location_attributes_should_convert_them_into_a_resource
      c = contacts['modifiable']
      # trigger loading
      c.location_attributes

      c.load(:location_attributes => {:spam => "Eggs"})
      c.location_attributes = {:foo => "bar"}

      assert_equal(c.location_attributes.spam, "Eggs")
      assert_equal(c.location_attributes.foo, "bar")
    end

    def test_setting_or_loading_account_attributes_should_convert_them_into_a_resource
      c = contacts['modifiable']
      # trigger loading
      c.account_attributes

      c.load(:account_attributes => {:spam => "Eggs"})
      c.account_attributes = {:foo => "bar"}

      assert_equal(c.account_attributes.spam, "Eggs")
      assert_equal(c.account_attributes.foo, "bar")
    end
  end

end; end
