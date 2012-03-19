module Infopark; module Crm; module Default
  class Role < Resource
    self.schema = {
      :description => :string,
      :name => :string,
      :permissions => :array,
    }
  end
end; end; end
