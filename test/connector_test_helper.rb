# ActiveResource related assertion extensions
#
module ConnectorTestHelper

  def assert_property(resource, key, value)
    assert resource.respond_to?(key),
        "Instance does not respond to #{key}: #{resource.inspect}"
    assert_equal value, resource.__send__(key), "Value for #{key}"
  end

  def assert_show_succeeds(klass, id, *args)
    hit = klass.find(id, *args)
    assert_not_nil hit, "No result for #{klass}.find(#{id})"
    assert klass === hit, "Unexpected klass #{hit.class}, expected #{klass}"
    hit
  end

  def assert_show_fails(klass, id)
    assert_raise ActiveResource::ResourceNotFound do
      klass.find(id)
    end
  end

  def assert_create_failed(resource, error_specs = nil)
    assert resource.new_record?
    if error_specs
      assert_validation_failed(resource, error_specs)
    end
  end

  def assert_validation_failed(resource, error_specs)
    Array(error_specs).each do |error|
      messages = resource.errors.full_messages
      matching_error = messages.detect{ |m| m =~ error }
      assert_not_nil matching_error, "Missing error #{error}, got #{messages.join("\n")}"
    end
  end

  def assert_update_succeeds(instance, success_properties)
    assert_saved instance.update_attributes(success_properties), instance,
        "Save with #{success_properties.inspect} failed"
  end

  def assert_update_by_save_succeeds(instance, success_properties)
    instance.load(success_properties)
    assert_saved instance.save, instance,
        "Save with #{success_properties.inspect} failed"
  end

  def assert_update_fails(instance, failure_properties)
    assert !instance.update_attributes(failure_properties), "Save did not fail with #{failure_properties.inspect}"
    instance
  end

  def assert_update_by_save_fails(instance, failure_properties)
    instance.load(failure_properties)
    assert !instance.save, "Save did not fail with #{failure_properties.inspect}"
    instance
  end

  def assert_create_succeeds(klass, success_properties)
    resource = klass.create(success_properties)
    assert_created(resource)
    resource
  end

  def assert_create_by_save_succeeds(klass, success_properties)
    resource = klass.new(success_properties)
    assert_save resource
    resource
  end

  def assert_save(resource, message = nil)
    assert_saved resource.save, resource, message
  end

  def assert_saved(success, resource, message = nil)
    message =
        if message
          message.strip
        else
          "#{resource.class} could not be saved"
        end
    message.gsub!(/[:.]$/, '')
    failures = ":\n  #{resource.errors.full_messages.join("\n  ")}"
    assert(success, message + failures)
  end

  def assert_create_fails(klass, failure_properties, error_specs = nil)
    resource = klass.create(failure_properties)
    assert_create_failed resource, error_specs
    resource
  end

  def assert_create_by_save_fails(klass, failure_properties, error_specs = nil)
    resource = klass.new(failure_properties)
    resource.save
    assert_create_failed resource, error_specs
    resource
  end

  def assert_created(resource)
    assert !resource.new_record?,
        "#{resource.class} was not saved successfully" \
        ":\n  #{resource.errors.full_messages.join("\n  ")}"
  end

  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods
    def wait_for_indexer
      sleep 5
    end
  end

end

module AbstractTestCaseDeclarable

  module ClassMethods
    def abstract_test_case
      klass = self
      define_method(:default_test) do
        unless self.class == klass
          super
        end
      end
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

end


module AssertionExtensions

  def assert_include(collection, obj, message=nil)
    assert_respond_to(collection, :include?)
    message ||= "#{collection.inspect}\ndoes not include\n#{obj.inspect}."
    assert_block(message) do
      collection.include?(obj)
    end
  end

  alias assert_includes assert_include

end

class ConnectorTestCase < Test::Unit::TestCase
  include ConnectorTestHelper
  include AssertionExtensions
  include AbstractTestCaseDeclarable
  abstract_test_case
end
