# :stopdoc:
module Infopark; module Crm
  module InheritingResource
    module ClassMethods
      def element_name
        superclass.element_name
      end

      def prefix(*args)
        superclass.prefix(*args)
      end

      def collection_name
        superclass.collection_name
      end

      def schema
        superclass.schema
      end

      def known_attributes
        superclass.known_attributes
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end; end
