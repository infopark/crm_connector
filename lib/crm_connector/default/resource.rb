# :stopdoc:
module Infopark; module Crm
  module Default
    class Resource < Infopark::Crm::Resource
      def self.defines_webservice?
        to_s.start_with?("Infopark::Crm::Default")
      end
    end
  end
end; end
