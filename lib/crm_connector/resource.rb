module Infopark; module Crm
  ##
  # (Extendable) base class for every resource model
  #
  # Supports the ActiveResource::Base lifecycle methods, like
  # * Resource.create(attributes)
  # * Resource.new(attributes)
  # * Resource.find(id)
  # * resource.update_attributes(attributes)
  # * resource.valid?
  # * resource.save
  #
  # See the ActiveResource documentation for a detailed description.
  class Resource < Core::Resource; end
end; end
