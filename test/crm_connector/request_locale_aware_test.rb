# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class RequestLocaleAwareTest < ConnectorTestCase
    def setup
      Infopark::Crm.configure {|c| c.locale = "de"}
    end

    def teardown
      Infopark::Crm.configure {|c| c.locale = nil}
    end

    def test_requests_are_sent_using_configured_locale
      assert_create_failed(Activity.create({}), /Tit(el|le) muss ausgefüllt werden/)
    end

    def test_requests_are_sent_using_current_locale_after_change
      assert_create_failed(Activity.create({}), /Tit(el|le) muss ausgefüllt werden/)
      Infopark::Crm.configure {|c| c.locale = "en"}
      assert_create_failed(Activity.create({}), /Title can't be blank/)
    end

  end

end; end
