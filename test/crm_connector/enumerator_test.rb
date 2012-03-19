# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class EnumeratorTest < ConnectorTestCase
    def test_count_available_with_size_given
      e = Core::Enumerator.new([], "abc", 98765) { |y| y.yield :x }
      assert_equal 98765, e.size
      # assert_equal 98765, e.count # Ruby 1.9 bug: ruby-core:40244
      assert e.count >= 1 # simple workaround check
    end

    def test_count_available_without_size
      e = Core::Enumerator.new([], "abc", nil) { |y| y.yield :x }
      assert_not_nil e.count
    end

    def test_update
      e = Core::Enumerator.new([], "abc", 123) { |y| y.yield :x }
      e.update([], "abc", 123)
      assert_not_nil e.count
    end
  end

end; end
