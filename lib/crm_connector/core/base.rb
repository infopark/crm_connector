require 'active_support/core_ext/class/attribute_accessors'

module Infopark; module Crm
  class ConnectorError < StandardError # :nodoc:
  end

  # Raised when a contact provides wrong credentials (token/password)
  #
  # This differs from the case when the web service api credentials are not accepted
  # (an ActiveResource error is raised then)
  class AuthenticationFailed < ConnectorError; end
end; end

module Infopark; module Crm; module Core
  class Base < ActiveResource::Base # :nodoc: all

    self.format = :json
    self.include_root_in_json = true

    cattr_accessor :locale
    cattr_accessor :http_host

    #--
    # TBD: drop when ActiveResource 3.0 support is dropped
    #++
    class SchemaSupport
      def self.schema_mapping
        @schema_mapping ||= {}
      end

      def self.add(mapping)
        schema_mapping.merge!(mapping)
      end

      def self.schema_type(type)
        default_mapping = ::ActiveResource::Schema::KNOWN_ATTRIBUTE_TYPES
        return type if default_mapping.include?(type.to_s)
        return schema_mapping[type.to_sym]
      end

      add :text => :string
      add :date => :string
      add :boolean => nil
    end

    def self.schema=(definition)
      ares_compatible_definition = {}
      definition.each do |k, v|
        ares_compatible_definition[k] = SchemaSupport.schema_type(v)
      end
      super(ares_compatible_definition)
    end

    #--
    # TBD: remove when https://github.com/rails/rails/issues/2479 is done
    #++
    def self.delete(id, options = {})
      connection.delete(element_path(id, options), headers)
    end

    def self.headers
      headers = super
      headers.merge!({"Accept-Language" => self.locale}) if self.locale
      headers.merge!({"Host" => self.http_host}) if self.http_host
      headers
    end

    def self.configure(configuration)
      self.site = configuration.url + '/' if configuration.url
      self.user = configuration.login
      self.password = configuration.api_key
      self.locale = configuration.locale
      self.http_host = configuration.http_host
      include Debugging if configuration.debug
    end

    # Support for field associatable errors (without humanized name guessing)
    def errors
      @errors ||= Errors.new(self)
    end

    class Errors < ActiveResource::Errors # :nodoc:
      # TBD temporary patch from https://rails.lighthouseapp.com/projects/8994-ruby-on-rails/tickets/5616
      def from_json(json, save_cache = false)
        errors = ActiveSupport::JSON.decode(json)
        clear unless save_cache
        errors.each do |attr_name, messages|
          Array.wrap(messages).each { |message| add(attr_name.to_sym, message) }
        end
      end

      def from_xml(xml, *args)
        errors = Hash.from_xml(xml)['errors'] rescue {}
        structured_errors = Array.wrap(errors['machine_readables'])
        if structured_errors.first
          clear unless args.first # see ActiveResource::Errors#from_array
          structured_errors.each do |h|
            h.each do |key, value|
              add(key, value)
            end
          end
        else
          # legacy omc and simple rails responses
          from_array(errors['error'] || [], *args)
        end
      end
    end

  end

end; end; end
