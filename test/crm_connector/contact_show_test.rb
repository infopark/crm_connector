# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class ContactShowTest < ConnectorTestCase
    class << self
      def startup
        login = SecureRandom.hex(8)
        @@account_id = Account.create(:name => "Moritz AG #{login}",
            :home_page => 'moritz_example.com').id
        @@contact_id = Contact.create(:last_name => 'und Moritz', :gender=> 'M',
            :language => 'en', :login => login, :account_id => @@account_id).id
      end
    end

    def test_show_contact_should_fetch_contact_for_id
      contact = assert_show_succeeds(Contact, @@contact_id)
      assert_equal('und Moritz', contact.last_name)
    end

    def test_show_contact_for_wrong_id_should_fail
      assert_show_fails(Contact, 9999)
    end

    def test_show_contact_with_null_should_fail
      assert_show_fails(Contact, nil)
    end

    def test_show_contact_account_object
      contact = Contact.find(@@contact_id)
      assert_not_nil(contact.account)
      assert_kind_of(Account, contact.account)
      assert_equal('moritz_example.com', contact.account.home_page)
    end

    def test_show_contact_account_object_with_no_account_should_be_nil
      contact = Contact.find(@@contact_id)
      contact.account_id = nil

      assert_nil(contact.account)
    end
  end

end; end
