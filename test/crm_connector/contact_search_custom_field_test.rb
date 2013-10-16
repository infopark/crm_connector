# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm
  class ContactSearchCustomFieldTest < ConnectorTestCase
    class << self
      def startup
        t = CustomType.find('contact')
        t.custom_attributes.reject! { |a| a.name == 'contact_test' }
        t.custom_attributes.push({:name => 'contact_test', :type => 'string'})
        t.save!
        @@unique_value = "Muster#{SecureRandom.hex(8)}"
        Contact.create(:last_name => 'Custom', :gender=> 'M', :language => 'en',
            :custom_contact_test => @@unique_value)
        Contact.create(:last_name => @@unique_value, :gender => 'M', :language => 'en',
            :custom_contact_test => "Not Muster")
      end
    end

    def test_search_should_with_q_find_custom_field
      eventually do
        result = Contact.search(:params => {:q => @@unique_value})
        assert_equal 2, result.size
      end
    end

    def test_search_with_custom_field_should_find_custom_field
      eventually do
        result = Contact.search(:params => {:custom_contact_test => @@unique_value})
        assert_equal 1, result.size
      end
    end
  end
end; end
