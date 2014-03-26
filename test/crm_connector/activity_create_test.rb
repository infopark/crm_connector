# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class ActivityCreateTest < ConnectorTestCase
    def self.startup
      CrmSetup.custom_types
      @@required_activity_params = {
          :title => 'Needs to be fixed',
          :kind => 'support case',
          :state => 'created',
          :email_cc => 'biene.maja@example.com',
          :priority => 3,
          }
    end

    def test_create_activity_should_be_successful
      assert_create_succeeds(Activity, @@required_activity_params)
    end

    def test_create_acitivity_without_state_should_be_successful
      activity = Activity.create({
          :kind => 'note',
          :title => 'Tagebuch'
          })
      assert_created(activity)
      assert_equal 'note', activity.kind
    end

    def test_create_activity_by_save_should_be_successful
      assert_create_by_save_succeeds(Activity, @@required_activity_params)
    end

    def test_create_acitivity_without_state_by_save_should_be_successful
      activity = Activity.new({
          :kind => 'note',
          :title => 'Tagebuch'
          })
      activity.save
      assert_created(activity)
      assert_equal 'note', activity.kind
    end

    def test_create_with_missing_mandatory_should_fail
      assert_create_failed(Activity.create({ :kind => 'note' }))
      assert_create_failed(Activity.create({ :title => 'Titel' }))
    end
  end

end; end
