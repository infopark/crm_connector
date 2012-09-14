module Infopark; module Crm; module Core

  # @private
  class KnownAttributes < Array
    def include?(val)
      val.start_with?('custom_') || super(val)
    end
  end

end; end; end
