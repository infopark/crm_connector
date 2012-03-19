# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm
  class ContactSearchCustomFieldTest < ConnectorTestCase
    class << self
      def startup
        t = CustomType.find('contact')
        t.custom_attributes.reject! { |a| a.name == 'custom_contact_test' }
        t.custom_attributes.push({:name => 'custom_contact_test', :type => 'string'})
        t.save!
        @@now = Time.new.to_i
        Contact.create(:last_name => 'Custom', :gender=> 'M', :language => 'en',
            :custom_custom_contact_test => "Muster#{@@now}")
        wait_for_indexer
      end
    end

    def test_search_should_find_custom_field
      result = Contact.search(:params => {:q => "Muster#{@@now}"})
      assert_equal 1, result.size
    end
  end
end; end
