# :stopdoc:
require 'ostruct'

module Infopark; module Crm; module Core
  class Resource < Infopark::Crm::Base
    include Core::ContinuationSupport
    include Core::SearchSupport

    def self.site
      Infopark::Crm::Base.site + 'api/'
    end

    @@deprecation_warnings = true
    cattr_writer :deprecation_warnings

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

    def known_attributes
      KnownAttributes.new(super)
    end

    # Inheritable Resources
    def self.defines_webservice?
      true
    end

    def self.inherited(sub)
      super
      sub.__send__(:include, InheritingResource) unless sub.defines_webservice?
    end

    # /Inheritable Resources
  end

end; end; end
