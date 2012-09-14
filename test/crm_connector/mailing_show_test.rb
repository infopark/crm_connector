# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class MailingShowTest < ConnectorTestCase

    class << self
      def startup
        @@mailing = Mailing.create({
          :mailing_type => 'i',
          :title => 'A show Mailing',
          :dtstart_at => Time.now,
          :body => 'normal body',
          :html_body => 'html body',
        })
      end
    end

    def test_show_mailing_should_fetch_mailing_for_id
      mailing = assert_show_succeeds(Mailing, @@mailing.id)
      assert_kind_of Mailing, mailing
      assert_property(mailing, :title, 'A show Mailing')
    end

    def test_show_mailing_for_wrong_id_should_fail
      assert_show_fails(Mailing, 9999)
    end

    def test_show_mailing_with_null_should_fail
      assert_show_fails(Mailing, nil)
    end

    def test_show_mailing_event_object
      CrmSetup.custom_types
      e = Event.create(:title => 'A mailing Event',
          :dtstart_at => Time.now,
          :dtend_at => Time.now + 1.day,
          :custom_attributes => [
            { :name => 'breakfast', :type => 'string' },
            { :name => 'lunch', :type => 'string' }
          ],
          :kind => 'base event')
      @@mailing.event_id = e.id
      @@mailing.save!

      assert_not_nil(@@mailing.event)
      assert_kind_of(Event, @@mailing.event)
      assert_equal('A mailing Event', @@mailing.event.title)
    end

    def test_show_mailing_event_object_with_no_event_should_be_nil
      @@mailing.event_id = nil
      @@mailing.save!

      assert_nil(@@mailing.event)
    end

  end
end; end
