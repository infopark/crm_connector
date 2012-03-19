# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class ContactLiveServerGroupsCallbackTest < ConnectorTestCase

    def setup
      Configuration.live_server_groups_callback =
        lambda {|contact|
          case contact.first_name
          when "Heinz"
            %w(admins)
          else
            []
          end
        }
    end

    def teardown
      Configuration.live_server_groups_callback = nil
    end

    def test_contact_may_have_arbitrary_live_server_groups_callback
      heinz = Contact.new(:first_name => 'Heinz')
      maria = Contact.new(:first_name => 'Maria')

      assert_equal %w(admins), heinz.live_server_groups
      assert_equal [], maria.live_server_groups
    end

    def test_contact_live_server_groups_can_be_set
      heinz = Contact.new(:first_name => 'Heinz')
      heinz.live_server_groups = ['user']
      assert_equal %w(user), heinz.live_server_groups
    end

    def test_contact_live_server_fails_when_a_broken_callback_is_given
      heinz = Contact.new(:first_name => 'Heinz')

      Configuration.live_server_groups_callback = nil
      assert_raise RuntimeError do
        heinz.live_server_groups
      end

      Configuration.live_server_groups_callback = ""
      assert_raise RuntimeError do
        heinz.live_server_groups
      end
    end

  end
end; end
