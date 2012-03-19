module Infopark; module Crm; module Default

  class Account < Resource
    ##
    # :singleton-method: search
    # ==== RESTful Web Service
    # GET /api/accounts/search
    # ==== Examples
    #   results = Infopark::Crm::Account.search(:params => {:account_group => account_group})
    #   results = Infopark::Crm::Account.search(:params => {:q => 'full-text search'})
    has_search

    self.schema = {
      :account_group => :string,
      :country => :string,
      :extended_address => :string,
      :home_page => :string,
      :locality => :string,
      :name => :string,
      :org_name_address => :string,
      :org_unit_address => :string,
      :phone => :string,
      :postalcode => :string,
      :region => :string,
      :street_address => :string,
      :tags => :array,
      :want_geo_location => :boolean,
    }
  end
end; end; end
