# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class TemplateTest < ConnectorTestCase
    def test_read_all
      result = System.templates
      assert_kind_of Hash, result
      assert result.size > 1, "Result count #{result.size} should be many"
    end

    def test_update_all
      templates = System.templates
      text = SecureRandom.hex(8)
      templates['test'] = text
      System.templates = templates
      templates = System.templates
      assert_equal text, templates['test']
    end

    def test_api_path
      begin
        orig_prefix = Core::Resource.prefix
        Core::Resource.prefix = '/here/we/go/api/'
        assert_equal '/here/we/go/api/templates', System.send(:path)
      ensure
        Core::Resource.prefix = orig_prefix
      end
    end
  end

end; end
