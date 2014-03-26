# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class ActivityNewTest < ConnectorTestCase
    def test_can_access_static_properties_of_activity
      @activity = Activity.new

      assert_nil @activity.account_id
      assert_nil @activity.appointment_contact_id
      assert_nil @activity.appointment_dtend_at
      assert_nil @activity.appointment_dtstart_at
      assert_nil @activity.appointment_location
      assert_nil @activity.comment_notes
      assert_nil @activity.comment_published
      assert_nil @activity.contact_id
      assert_nil @activity.email_cc
      assert_nil @activity.kind
      assert_nil @activity.state
      assert_nil @activity.tags
      assert_nil @activity.task_due_at
      assert_nil @activity.task_owner_id
      assert_nil @activity.title
    end

    def test_can_access_custom_properties_of_activity
      assert_nil Activity.new.custom_message
      assert_nil Activity.new.custom_whatever
    end
  end
end; end
