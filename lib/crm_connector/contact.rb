module Infopark; module Crm
  class Contact < Core::Resource

    ##
    # @!method self.search(input)
    # Searches for contacts
    # @param input [Hash] A hash containing a +params+ key. The value of this key is a hash containing the actual search query.
    # @return [Array<Infopark::Crm::Contact>]
    # @webcrm_rest_url <code>GET /api/contacts/search</code>
    # @example
    #   results = Infopark::Crm::Contact.search(:params => {:login => 'the_login'})
    #   results = Infopark::Crm::Contact.search(:params => {:email => 'email@example.com'})
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

    ##
    # Queries the WebCRM for the Account with the id +account_id+.
    # @return [Infopark::Crm::Account] The account associated with this contact, if +account_id+ is present.
    # @webcrm_rest_url <code>GET /api/accounts/_account_id_</code>
    def account
      Infopark::Crm::Account.find(account_id) if account_id
    end

    ##
    # Looks for the user with the given +login+ and check whether the +password+ is correct.
    # @param login [String]
    # @param password [String]
    # @return [Infopark::Crm::Contact] The found and authenticated contact.
    # @raise [Infopark::Crm::Errors::AuthenticationFailed] if provided +password+ is not correct.
    # @webcrm_rest_url <code>POST /api/contacts/authenticate</code>
    def self.authenticate(login, password)
      begin
        response = post(:authenticate, {}, format.encode({:login => login, :password => password}))
        result = format.decode(response.body)
        return find(result['id']) if result.kind_of? Hash # ActiveResource 3.0
        find(result)
      rescue ActiveResource::ResourceInvalid
        raise Errors::AuthenticationFailed
      end
    end

    ##
    # Sets a new +password+ for the contact, which is associated with the given +token+.
    # @param password [String] The new password.
    # @param token [String] The token provided by +password_request+ which is associated with a contact.
    # @return [String] The result message from the server.
    # @webcrm_rest_url <code>POST /api/contacts/password_set</code>
    def self.password_set(password, token)
      response = post(:password_set, {}, format.encode({:password => password, :token => token}))
      result = format.decode(response.body)
      return result['message'] if result.kind_of? Hash # ActiveResource 3.0
      result
    end

    ##
    # Sets the password of this contact to +password+.
    # @param password [String] the new password
    # @return [void]
    def password_set(password)
      token = password_request(:params => {:only_get_token => true})
      self.class.password_set(password, token)
    end

    ##
    # Instructs the WebCRM to send the user an e-mail to let them set a new password.
    # @param options [Hash]
    # @webcrm_rest_url <code>GET /api/contacts/_id_/password_request</code>
    # @webcrm_todo return nil instead of message for default parameters?
    def password_request(options = {})
      params = options[:params] || {}
      response = post(:password_request, {}, self.class.format.encode(params))
      result = self.class.format.decode(response.body)
      return result.values.first if result.kind_of? Hash # ActiveResource 3.0
      result
    end

    # Returns the live_server_groups of this contact as defined by +Configuration.live_server_groups_callback+
    # @return [Array<String>] The calculated roles of this contact.
    def live_server_groups
      return @live_server_groups if defined?(@live_server_groups)
      callback = Configuration.live_server_groups_callback
      @live_server_groups = callback.call(self) if callback.respond_to?(:call)
      raise "live_server_groups_callback: not defined or unexpected result!" unless @live_server_groups

      @live_server_groups
    end

    ##
    # Overwrites +live_server_groups+, so live_server_groups_callback is not called for this object.
    # @return [void]
    def live_server_groups=(value)
      @live_server_groups = value
    end

  end
end; end
