module Infopark; module Crm

  class Account < Core::Resource

    ##
    # @!method self.search(input)
    # Searches for accounts
    # @param input [Hash] A hash containing a +params+ key. The value of this key is a hash containing the actual search query.
    # @return [Core::Enumerator<Infopark::Crm::Account>]
    # @webcrm_rest_url <code>GET /api/accounts/search</code>
    # @example
    #   results = Infopark::Crm::Account.search(:params => {:account_group => 'account_group_name'})
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
end; end
