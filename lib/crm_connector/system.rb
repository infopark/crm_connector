module Infopark; module Crm

  ##
  # @note Implementation and naming may change
  class System

    ##
    # Reads the definition of all WebCRM templates.
    # @return [Hash]
    # @webcrm_rest_url <code>GET /api/templates</code>
    def self.templates
      response = base.connection.get(path, base.headers)
      return response['templates'] if response.kind_of? Hash # ActiveResource 3.0
      base.format.decode(response.body)
    end

    ##
    # Sets the definition of all WebCRM templates
    # @param hash [Hash] the new definition of all WebCRM templates
    def self.templates=(hash)
      data = {'templates' => hash}
      base.connection.put(path, base.format.encode(data), base.headers)
    end

    private

    def self.base
      Infopark::Crm::Core::Resource
    end

    def self.path
      base.prefix + 'templates'
    end
  end
end; end
