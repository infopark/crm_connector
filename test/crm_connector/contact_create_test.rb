# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class ContactCreateTest < ConnectorTestCase
    
    class << self
      def startup
        a = Account.new(:name => 'Z Count', :want_geo_location => false)
        a.save!
        @@account_id = a.id
      end
    end    

    def test_create_for_an_account_should_be_successful
      contact = Contact.create({
          :last_name => "Graf #{Time.now.to_f}",
          :title => '',
          :language => 'de',
          :gender => 'M',
          :account_id => @@account_id,
          })
      assert_created(contact)
    end

    def test_create_for_an_account_by_save_should_be_successful
      contact = Contact.new({
          :last_name => "Graf #{Time.now.to_f}",
          :title => '',
          :language => 'de',
          :gender => 'M',
          :account_id => @@account_id,
          })
      contact.save
      assert_created(contact)
    end

    def pending_test_create_for_an_invalid_account_should_fail
      contact = Contact.create({
          :last_name => "Graf #{Time.now.to_f}",
          :title => '',
          :language => 'de',
          :gender => 'M',
          :account_id => '12345'
          })
      assert_create_failed(contact, /Account is invalid/)
    end

    def pending_test_create_for_an_invalid_account_by_save_should_fail
      contact = Contact.new({
          :last_name => "Graf #{Time.now.to_f}",
          :title => '',
          :language => 'de',
          :gender => 'M',
          :account_id => '12345'
          })
      contact.save
      assert_create_failed(contact, /Account is invalid/)
    end

    def test_create_without_account_should_be_successful
      contact = Contact.create({
          :last_name => "Graf #{Time.now.to_f}",
          :title => '',
          :gender => 'M',
          :language => 'de',
          })
      assert_created(contact)
    end

    def test_create_without_account_by_save_should_be_successful
      contact = Contact.new({
          :last_name => "Graf #{Time.now.to_f}",
          :title => '',
          :gender => 'M',
          :language => 'de',
          })
      contact.save
      assert_created(contact)
    end

    def test_create_with_account_and_location_properties_should_be_successful
      contact = Contact.create({
          :last_name => "Graf #{Time.now.to_f}",
          :title => '',
          :language => 'de',
          :gender => 'M',
          :account_id => @@account_id,
          :locality => 'Zremen',
          :want_geo_location => false,
      })
      assert_created(contact)
      assert_equal('Z Count', Contact.find(contact.id).account.name)
      assert_equal('Zremen', Contact.find(contact.id).locality)
    end

    def test_create_with_account_and_location_properties_by_save_should_be_successful
      contact = Contact.new({
          :last_name => "Graf #{Time.now.to_f}",
          :title => '',
          :language => 'de',
          :gender => 'M',
          :account_id => @@account_id,
          :locality => 'Zremen',
          :want_geo_location => false,
      })
      contact.save
      assert_created(contact)
      assert_equal('Z Count', Contact.find(contact.id).account.name)
      assert_equal('Zremen', Contact.find(contact.id).locality)
    end
  end

end; end
