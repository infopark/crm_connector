# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class ActivityUpdateTest < ConnectorTestCase
    class << self
      def startup
        CrmSetup.custom_types
        @@activity = Activity.create(:kind => 'support case', :state=>'created', :title => 'Changeme')
      end
    end

    def test_update_is_successful
      @@activity.title = 'Ganz anderes Thema'
      assert_save @@activity
    end

    def pending_test_illegal_update_fails
      assert_update_fails(@@activity, :kind => 'invalid kind')
    end
  end

end; end
