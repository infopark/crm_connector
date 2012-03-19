module Infopark; module Crm
  # ==== Please note
  # Implementation and naming may change
  #--
  # TBD sync with web service
  #++
  class System
    def self.templates
      response = base.connection.get(path, base.headers)
      return response['templates'] if response.kind_of? Hash # ActiveResource 3.0
      base.format.decode(response.body)
    end

    def self.templates=(hash)
      data = {'templates' => hash}
      base.connection.put(path, base.format.encode(data), base.headers)
    end

    private

    def self.base #:nodoc:
      Infopark::Crm::Resource
    end

    def self.path #:nodoc:
      base.prefix + 'templates'
    end
  end
end; end
