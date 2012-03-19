require 'active_resource'
require 'active_support/core_ext/string/conversions'

module Infopark; module Crm
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

  # exceptions (defined elsewhere)
  autoload :AuthenticationFailed, File.expand_path('../crm_connector/core/base', __FILE__)

end; end

module Infopark; module Crm

  # Configures the web service connection
  #
  # View {README}[link:README_rdoc.html] for a usage example.
  #
  # Supported configuration keys are:
  # [url] the web service server url (schema, host, port, path (up to, but not including /api))
  #
  # [login] the login of a WebCRM user with an API key (web service credential)
  #
  # [api_key] the WebCRM user's valid api key (web service credential)
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
  # [live_server_groups_callback] A custom definition of what the live_server_groups of
  #                               a contact is. The provided lambda is called with the contact
  #                               instance and must return an array of live_server_groups (strings)
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
  # [debug] When set to true, includes the module Debugging into every resource, which
  #         provides a logger method. Cannot be reverted by setting to +false+
  #
  def self.configure(&block)
    yield Configuration

    Core::Base.configure(Configuration)
  end

end; end
