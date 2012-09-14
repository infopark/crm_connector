# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm
  class AccountSearchCustomFieldTest < ConnectorTestCase
    class << self
      def startup
        t = CustomType.find('account')
        t.custom_attributes.reject! { |a| a.name == 'account_test' }
        t.custom_attributes.push({:name => 'account_test', :type => 'string'})
        t.save!
        @@now = Time.new.to_i
        Account.create(:name => 'Custom', :custom_account_test => "Master#{@@now}")
        Account.create(:name => "Master#{@@now}", :custom_account_test => "Not Master")
        wait_for_indexer
      end
    end

    def test_search_should_with_q_find_custom_field
      result = Account.search(:params => {:q => "Master#{@@now}"})
      assert_equal 2, result.size
    end

    def test_search_with_custom_field_should_find_custom_field
      result = Account.search(:params => {:custom_account_test => "Master#{@@now}"})
      assert_equal 1, result.size
    end
  end
end; end
