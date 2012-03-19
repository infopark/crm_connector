module Infopark; module Crm; module Default
  class Contact < Resource

    ##
    # :singleton-method: search
    # ==== RESTful Web Service
    # GET /api/contacts/search
    # ==== Examples
    #   results = Infopark::Crm::Contact.search(:params => {:login => login})
    #   results = Infopark::Crm::Contact.search(:params => {:email => email})
    #   results = Infopark::Crm::Contact.search(:params => {:q => 'full-text search'})
    has_search

    self.schema = {
      :account_id => :string,
      :country => :string,
      :email => :string,
      :extended_address => :string,
      :fax => :string,
      :first_name => :string,
      :gender => :string,
      :job_title => :string,
      :language => :string,
      :last_name => :string,
      :locality => :string,
      :login => :string,
      :mobile_phone => :string,
      :name_prefix => :string,
      :org_name_address => :string,
      :org_unit_address => :string,
      :phone => :string,
      :postalcode => :string,
      :region => :string,
      :role_names => :array,
      :street_address => :string,
      :tags => :array,
      :want_email => :boolean,
      :want_geo_location => :boolean,
      :want_phonecall => :boolean,
      :want_snailmail => :boolean,
    }

    # Queries the WebCRM for the Account with the id +account_id+.
    # Returns +nil+ if +account_id+ is +nil+.
    def account
      Infopark::Crm::Account.find(account_id) if account_id
    end

    # ==== RESTful Web Service
    # POST /api/contacts/authenticate
    def self.authenticate(login, password)
      begin
        response = post(:authenticate, {}, format.encode({:login => login, :password => password}))
        result = format.decode(response.body)
        return find(result['id']) if result.kind_of? Hash # ActiveResource 3.0
        find(result)
      rescue ActiveResource::ResourceInvalid
        raise AuthenticationFailed
      end
    end

    # ==== RESTful Web Service
    # POST /api/contacts/password_set
    def self.password_set(password, token)
      response = post(:password_set, {}, format.encode({:password => password, :token => token}))
      result = format.decode(response.body)
      return result['message'] if result.kind_of? Hash # ActiveResource 3.0
      result
    end

    #--
    # ==== RESTful Web Service
    # POST /api/contacts/:id/password_set
    #--
    # TBD: build this api and use it
    #++
    # Shortcut to set the password of this contact.
    def password_set(password)
      token = password_request(:params => {:only_get_token => true})
      self.class.password_set(password, token)
    end

    # ==== RESTful Web Service
    # GET /api/contacts/:id/password_request
    #--
    # TBD: return nil instead of message for default parameters?
    #++
    def password_request(options = {})
      params = options[:params] || {}
      response = post(:password_request, {}, self.class.format.encode(params))
      result = self.class.format.decode(response.body)
      return result.values.first if result.kind_of? Hash # ActiveResource 3.0
      result
    end

    # Returns the live_server_groups of this contact as defined by Configuration.live_server_groups_callback
    def live_server_groups
      return @live_server_groups if defined?(@live_server_groups)
      callback = Configuration.live_server_groups_callback
      @live_server_groups = callback.call(self) if callback.respond_to?(:call)
      raise "live_server_groups_callback: not defined or unexpected result!" unless @live_server_groups

      @live_server_groups
    end

    # Overwrites live_server_groups, so live_server_groups_callback is not called for this object.
    def live_server_groups=(value)
      @live_server_groups = value
    end

  end
end; end; end
