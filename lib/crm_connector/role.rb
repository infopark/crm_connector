module Infopark; module Crm
  class Role < Core::Resource
    self.schema = {
      :description => :string,
      :name => :string,
      :permissions => :array,
    }
  end
end; end
