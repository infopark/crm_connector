# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class MailingCreateTest < ConnectorTestCase

    def test_create_mailing_should_be_successful
      assert_create_succeeds(Mailing, {
        :mailing_type => 'i',
        :title => 'A Mailing',
        :dtstart_at => Time.now,
        :body => 'normal body',
        :html_body => 'html body',
        })
    end

    def test_create_mailing_by_save_should_be_successful
      assert_create_by_save_succeeds(Mailing, {
        :mailing_type => 'i',
        :title => 'A other Mailing',
        :dtstart_at => Time.now,
        :body => 'normal body',
        :html_body => 'html body',
        })
    end

    def test_create_mailing_with_insufficient_properties_should_fail
      assert_create_fails(Mailing, :body => 'body')
    end

    def test_create_mailing_with_insufficient_properties_by_save_should_fail
      assert_create_by_save_fails(Mailing, :body => 'body')
    end

  end

end; end
