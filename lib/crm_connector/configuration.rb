require 'active_support/core_ext/class/attribute_accessors'

module Infopark; module Crm

  # @private
  class Configuration

    cattr_accessor :api_key

    cattr_accessor :login

    cattr_accessor :url

    cattr_accessor :locale

    cattr_accessor :http_host

    cattr_accessor :live_server_groups_callback

    self.login = "webservice"

    self.live_server_groups_callback = lambda {|contact| []}

  end
end; end
