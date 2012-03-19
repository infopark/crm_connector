module Infopark; module Crm
  # This is an extendable class. See Default::CustomType for documentation
  class CustomType < Default::CustomType
    class CustomAttribute < Default::CustomType::CustomAttribute #:nodoc:
    end
  end
end; end
