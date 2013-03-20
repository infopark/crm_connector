# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class MailingUpdateTest < ConnectorTestCase
    def self.startup
      @@mailing_name = "Mailing_#{SecureRandom.hex(8)}"
      @@mailing = Mailing.create({
          :name => @@mailing_name,
          :mailing_type => 'i',
          :title => 'A Mailing title',
          :dtstart_at => Time.now,
          })
    end

    def test_updating_an_mailing_should_be_successful
      assert_update_succeeds(@@mailing, :title => 'Changed mailing title')
      assert_equal 'Changed mailing title', Mailing.find(@@mailing.id).title
    end

    def test_updating_an_mailing_by_save_should_be_successful
      assert_update_by_save_succeeds(@@mailing, :title => 'Another changed mailing title')
      assert_equal 'Another changed mailing title', Mailing.find(@@mailing.id).title
    end

    def test_updating_an_mailing_with_invalid_properties_should_fail
      assert_update_fails(@@mailing, :title => '')
      assert_validation_failed(@@mailing, /Title can't be blank/)
    end

    def test_updating_an_mailing_with_invalid_properties_by_save_should_fail
      assert_update_by_save_fails(@@mailing, :title => '')
      assert_validation_failed(@@mailing, /Title can't be blank/)
    end
  end

end; end
