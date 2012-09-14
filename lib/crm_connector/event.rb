module Infopark; module Crm
  class Event < Core::Resource

    ##
    # @!method self.search(input)
    # Searches for events
    # @param input [Hash] A hash containing a +params+ key. The value of this key is a hash containing the actual search query.
    # @return [Array<Infopark::Crm::Event>]
    # @webcrm_rest_url <code>GET /api/events/search</code>
    # @example
    #   results = Infopark::Crm::Event.search(:params => {:kind => kind})
    #   results = Infopark::Crm::Event.search(:params => {:event_set => event_set})
    #   results = Infopark::Crm::Event.search(:params => {:q => 'full-text search'})
    has_search

    self.schema = {
      :custom_attributes => :hash,
      :dtend_at => :time,
      :dtstart_at => :time,
      :event_set => :string,
      :kind => :string,
      :location => :string,
      :title => :string,
    }
  end

  # @private
  class Event::CustomAttribute < Core::Resource

    self.include_root_in_json = false

    ##
    # @webcrm_todo this method is only needed until the deprecated Object#type is removed
    #   Better: define self.schema
    def type
      attributes['type']
    end
  end
end; end
