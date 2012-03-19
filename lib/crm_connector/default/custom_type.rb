module Infopark; module Crm; module Default
  class CustomType < Resource
    self.schema = {
      :custom_attributes => :hash,
      :icon_css_class => :string,
      :kind => :string,
      :name => :string,
      :states => :array,
    }

    class CustomAttribute < Resource #:nodoc:

      self.include_root_in_json = false

      #--
      # TBD: this method is only needed until the deprecated Object#type is removed
      # Better: define self.schema
      #++
      def type #:nodoc:
        attributes['type']
      end
    end
  end
end; end; end
