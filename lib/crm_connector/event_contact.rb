module Infopark; module Crm
  class EventContact < Core::Resource

    ##
    # @!method self.search(input)
    # Searches for event contacts
    # @param input [Hash] A hash containing a +params+ key. The value of this key is a hash containing the actual search query.
    # @return [Array<Infopark::Crm::EventContact>]
    # @webcrm_rest_url <code>GET /api/event_contacts/search</code>
    # @example
    #   results = Infopark::Crm::EventContacts.search(:params => {:event_id => eid})
    #   results = Infopark::Crm::EventContacts.search(:params => {:contact_id => cid})
    #   results = Infopark::Crm::EventContacts.search(:params => {:state => state})
    #   results = Infopark::Crm::EventContacts.search(:params => {:q => 'full-text search'})
    has_search

    self.schema = {
      :state => :string,
      :contact_id => :string,
      :event_id => :string,
    }

    ##
    # Queries the WebCRM for the Contact with the id +contact_id+.
    # @return [Infopark::Crm::Contact] The contact associated with this event contact, if +contact_id+ is present.
    # @webcrm_rest_url <code>GET /api/contacts/_contact_id_</code>
    def contact
      Infopark::Crm::Contact.find(contact_id) if contact_id
    end

    ##
    # Queries the WebCRM for the Event with the id +event_id+.
    # @return [Infopark::Crm::Event] The event associated with this event contact, if +event_id+ is present.
    # @webcrm_rest_url <code>GET /api/events/_event_id_</code>
    def event
      Infopark::Crm::Event.find(event_id) if event_id
    end

  end
end; end
