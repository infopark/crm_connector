require 'active_support/core_ext/class/attribute_accessors'

module Infopark; module Crm; module Core
  ##
  # Base class for every resource model
  #
  # Supports the ActiveResource::Base lifecycle methods, such as
  # * Resource.create(attributes)
  # * Resource.new(attributes)
  # * Resource.find(id)
  # * resource.update_attributes(attributes)
  # * resource.save
  #
  # See the {http://rubydoc.info/gems/activeresource/3.2.8/frames ActiveResource documentation} for a detailed description.
  class Resource < ActiveResource::Base
    include ContinuationSupport
    include SearchSupport

    self.format = :json
    self.include_root_in_json = true

    cattr_accessor :locale
    cattr_accessor :http_host

    # @private
    def self.element_name
      @element_name ||= first_resource_child.model_name.element
    end

    # @private
    @@deprecation_warnings = true
    cattr_writer :deprecation_warnings

    # @private
    def self.inherited(subclass)
      subclass.schema = schema
    end

    # @private
    def self.deprecated(deprecated, hint = nil)
      return unless @@deprecation_warnings
      text = "[WebCrmConnector] #{deprecated} is deprecated."
      text << " #{hint}" if hint
      if defined?(Rails.logger)
        Rails.logger.warn(text)
      else
        $stderr.puts(text)
      end
    end

    # @private
    def known_attributes
      Core::KnownAttributes.new(super)
    end

    ##
    # @webcrm_todo remove when https://github.com/rails/rails/issues/2479 is done
    # @private
    def self.delete(id, options = {})
      connection.delete(element_path(id, options), headers)
    end

    # @private
    def self.headers
      headers = super
      headers.merge!({"Accept-Language" => self.locale}) if self.locale
      headers.merge!({"Host" => self.http_host}) if self.http_host
      headers
    end

    # @private
    def self.configure(configuration)
      self.site = configuration.url + '/api/' if configuration.url
      self.user = configuration.login
      self.password = configuration.api_key
      self.locale = configuration.locale
      self.http_host = configuration.http_host
    end

    # @private
    def self.schema=(definition)
      ares_compatible_definition = {}
      (definition || []).each do |k, v|
        ares_compatible_definition[k] = SchemaSupport.schema_type(v)
      end
      super(ares_compatible_definition)
    end

    ###
    # @webcrm_todo drop when ActiveResource 3.0 support is dropped
    # @private
    class SchemaSupport
      def self.schema_mapping
        @schema_mapping ||= {}
      end

      def self.add(mapping)
        schema_mapping.merge!(mapping)
      end

      def self.schema_type(type)
        if type.present?
          default_mapping = ::ActiveResource::Schema::KNOWN_ATTRIBUTE_TYPES
          if default_mapping.include?(type.to_s)
            type
          else
            schema_mapping[type.to_sym]
          end
        else
          nil
        end
      end

      add :text => :string
      add :date => :string
      add :boolean => nil
    end

    # Support for field associatable errors (without humanized name guessing)
    # @private
    def errors
      @errors ||= Errors.new(self)
    end

    # @private
    class Errors < ActiveResource::Errors

      ##
      # @webcrm_todo temporary patch from https://rails.lighthouseapp.com/projects/8994-ruby-on-rails/tickets/5616
      def from_json(json, save_cache = false)
        errors = ActiveSupport::JSON.decode(json)
        clear unless save_cache
        errors.each do |attr_name, messages|
          Array.wrap(messages).each { |message| add(attr_name.to_sym, message) }
        end
      end

    end

    private

    def self.first_resource_child
      ancestors.each_cons(2) do |child, parent|
        return child if (parent == Infopark::Crm::Core::Resource)
      end
    end
  end
end; end; end
