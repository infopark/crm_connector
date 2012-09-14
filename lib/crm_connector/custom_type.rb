module Infopark; module Crm
  class CustomType < Core::Resource
    self.schema = {
      :custom_attributes => :hash,
      :icon_css_class => :string,
      :kind => :string,
      :name => :string,
      :states => :array,
    }

    # @private
    class CustomAttribute < Core::Resource

      self.include_root_in_json = false

      ###
      # @webcrm_todo this method is only needed until the deprecated Object#type is removed
      #   Better: define self.schema
      def type
        attributes['type']
      end
    end
  end
end; end
