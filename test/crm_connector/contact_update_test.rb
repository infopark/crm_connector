# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class ContactUpdateTest < ConnectorTestCase
    class << self
      def startup
        @@max = Contact.create(:last_name => 'Max', :gender=> 'M',
            :language => 'de', :login => SecureRandom.hex(16))
      end
    end

    def test_updating_a_contact_should_be_successful
      assert_update_succeeds(@@max, :language => 'en')
    end

    def test_updating_a_contact_by_save_should_be_successful
      assert_update_by_save_succeeds(@@max, :language => 'en')
    end

    def pending_test_invalid_updating_a_contact_should_fail
      assert_update_fails(@@max, :last_name => '')
    end

    def pending_test_invalid_updating_a_contact_by_save_should_fail
      assert_update_by_save_fails(@@max, :last_name => '')
    end

    def pending_test_updating_a_contact_with_account_andor_location_properties_should_be_sucessful
      assert_update_succeeds(@@max, {
        :language => 'de',
        :account_attributes => {
          :name => 'Zhanged Inc.',
        },
        :location_attributes => {
          :city => 'Zhangetown'
        }
      })
      max_again = Contact.find(@@max.id)
      assert_equal('Zhanged Inc.', max_again.account.name)
      assert_equal('Zhangetown', max_again.location.city)
    end

    def pending_test_updating_a_contact_with_account_andor_location_properties_by_save_should_be_sucessful
      assert_update_by_save_succeeds(@@max, {
        :language => 'de',
        :account_attributes => {
          :name => 'Zhanged Inc.',
        },
        :location_attributes => {
          :city => 'Zhangetown'
        }
      })
      max_again = Contact.find(@max.id)
      assert_equal('Zhanged Inc.', max_again.account.name)
      assert_equal('Zhangetown', max_again.location.city)
    end
  end

end; end
