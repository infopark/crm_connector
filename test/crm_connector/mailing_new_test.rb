# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class MailingNewTest < ConnectorTestCase
    def test_can_access_static_properties_of_mailing
      @mailing = Mailing.new

      # this is a hash property
      assert_nil @mailing.body
      assert_nil @mailing.dtstart_at
      assert_nil @mailing.email_from
      assert_nil @mailing.email_reply_to
      assert_nil @mailing.email_subject
      assert_nil @mailing.event_id
      assert_nil @mailing.html_body
      assert_nil @mailing.mailing_type
      assert_nil @mailing.title
    end
  end
end; end
