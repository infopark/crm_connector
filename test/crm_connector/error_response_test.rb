# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class ErrorResponseTest < ConnectorTestCase

    class FailingResource < Resource
    end

    def setup
      FailingResource.site = FailingResource.site.dup
      FailingResource.connection.instance_eval do
        def handle_response(response)
          raise ActiveResource::ServerError.new(response)
        end
      end
    end

    def test_500_response_reason_is_available
      begin
        FailingResource.find('unknown')
      rescue ActiveResource::ServerError => e
        assert_match /<h1>.*Error.*<\/h1>/i, e.response.body
        return
      end
      fail "Test setup error"
    end

  end

end; end
