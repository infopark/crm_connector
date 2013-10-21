# encoding: utf-8

require 'backports'
require 'rest-client'
require_relative '../test_helper'

module Infopark; module Crm

  class ActivityAddAttachmentTest < ConnectorTestCase
    def startup
      CrmSetup.custom_types
    end

    def test_walk_through_activity_add_attachment_workflow
      perm = Attachment.upload_permission
      assert_kind_of Attachment::Permission, perm
      assert_kind_of String, perm.url
      assert_kind_of Hash, perm.fields
      assert_kind_of String, perm.upload_id

      params = ActiveSupport::OrderedHash.new
      params.merge!(perm.fields)
      params.merge!(:file => File.new('LICENSE'))
      response = RestClient.post(perm.url, params)
      assert_equal 204, response.code

      activity = Activity.create(:kind => 'support case',
          :state=>'created', :title => 'attachment test')
      activity.comment_notes = "See the attached file"
      activity.comment_attachments = ["#{perm.upload_id}/LICENSE.txt"]
      activity.save

      eventually do
        activity = Activity.find(activity.id)
        attachment_id = activity.comments.last.attachments.first
        assert_match(/LICENSE\.txt$/, attachment_id)

        download_url = Attachment.download_url(attachment_id, activity.id)
        assert_match(/amazonaws/, download_url)
      end
    end

  end

end; end

