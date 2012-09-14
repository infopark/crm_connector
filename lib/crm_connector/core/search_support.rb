module Infopark; module Crm; module Core

  # @private
  module SearchSupport
    def self.included(klass)
      klass.extend(ClassMethods)
    end

    module ClassMethods

      # adds a search method
      def has_search
        class << self
          def search(options)
            get_with_continuation(:search, options)
          end
        end
      end

    end
  end

end; end; end
