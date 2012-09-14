# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class ErrorResponseTest < ConnectorTestCase

    class FailingResource < Core::Resource
    end

    def setup
      FailingResource.site = FailingResource.site.dup
      FailingResource.connection.instance_eval do
        def handle_response(response)
          raise ActiveResource::ServerError.new(response)
        end
      end
    end

    def teardown
      WebMock.disable!
    end

    def test_unknown_resource_should_throw_an_exception
      begin
        FailingResource.find('unknown')
      rescue ActiveResource::ServerError => e
        return
      end
      fail "Test setup error"
    end

    def test_error_message_is_available
      WebMock.enable!
      stub_request(:get, %r{https?://.*/api/failing_resources/unknown.json}).
        to_return(:status => 500, :body => "This is, what went wrong: ****", :headers => {})
      begin
        FailingResource.find('unknown')
      rescue ActiveResource::ServerError => e
        assert_match "This is, what went wrong: ****", e.response.body
        return
      end
      fail "Test setup error"
    end

  end

end; end
