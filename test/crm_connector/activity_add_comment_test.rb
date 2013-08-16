# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class ActivityAddCommentTest < ConnectorTestCase
    class << self
      def startup
        CrmSetup.custom_types
        @@activity = Activity.create(:kind => 'support case', :state=>'created', :title => 'Changeme')
        @@old_comments = @@activity.comments
        @@activity.comment_notes = 'Ein neuer Kommentar'
        @@activity.comment_published = true
        @@contact = Contact.first
        @@activity.comment_contact_id = @@contact.id
      end
    end

    def test_update_is_successful
      assert_save @@activity
    end

    def test_activity_has_a_new_comments
      @@activity.save
      # reload activity
      @@activity = Activity.find( @@activity.id )
      assert @@old_comments.size < @@activity.comments.size, "activity should now have more comments"
    end

    def test_activity_s_new_comments_has_set_content
      @@activity.save
      # reload activity
      @@activity = Activity.find( @@activity.id )
      assert_equal 'Ein neuer Kommentar', @@activity.comments.last.notes
      assert_equal @@contact.id, @@activity.comments.last.contact_id
    end

  end

end; end
