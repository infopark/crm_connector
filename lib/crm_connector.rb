require 'active_resource'
require 'active_support/core_ext/string/conversions'

module Infopark; module Crm
  # @private
  def self.setup_autoload(mod, mod_source)
    dir = File.expand_path(".", mod_source)[0..-4] # - ".rb"
    pattern = "#{dir}/*.rb"
    Dir.glob(pattern).each do |file|
      file = file[0..-4]
      const = "#{file[dir.length..-1]}".gsub(%r{[_/](.)}) {$1.upcase}
      mod.autoload const.to_sym, file
    end
  end

  setup_autoload(self, __FILE__)
end; end

module Infopark; module Crm

  # Configures the web services connection
  #
  # View {file:README.markdown README} for a usage example.
  #
  # Supported configuration keys are:
  # [url] The web services server url (schema, host, port, path (up to, but not including /api)).
  #
  # [login] The user name (login) of the WebCRM contact person.
  #
  # [api_key] The WebCRM user's valid API key (web services credential).
  #
  # [locale] The locale to use when sending requests to the server. Can be
  #          redefined at any time.
  #
  #          Example:
  #
  #            Infopark::Crm.configure do |configuration|
  #              configuration.locale = I18n.locale
  #            end
  #
  #            Infopark::Crm::Contact.create.errors.full_messages
  #
  # [live_server_groups_callback] A custom definition of what a contact's live_server_groups field
  #                               returns. Provide a lambda that takes the contact instance as an
  #                               argument and returns an array of live_server_groups (strings).
  #
  #                               Example:
  #
  #                                 Infopark::Crm.configure do |configuration|
  #                                   configuration.live_server_groups_callback = lambda {|contact|
  #                                     case contact.account.name
  #                                     when "MyCompany"
  #                                       %w(admin reader writer)
  #                                     else
  #                                       %w(reader)
  #                                     end
  #                                   }
  #                                 end
  #
  #
  # @return [void]
  def self.configure(&block)
    yield Configuration

    Core::Resource.configure(Configuration)
  end

end; end
