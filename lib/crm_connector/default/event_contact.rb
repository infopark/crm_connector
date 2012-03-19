module Infopark; module Crm; module Default
  class EventContact < Resource

    ##
    # :singleton-method: search
    # ==== RESTful Web Service
    # GET /api/event_contacts/search
    # ==== Examples
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

    # Queries the WebCRM for the Contact with the id +contact_id+.
    # Returns +nil+ if +contact_id+ is +nil+.
    def contact
      Infopark::Crm::Contact.find(contact_id) if contact_id
    end

    # Queries the WebCRM for the Event with the id +event_id+.
    # Returns +nil+ if +event_id+ is +nil+.
    def event
      Infopark::Crm::Event.find(event_id) if event_id
    end

    # ==== DEPRECATED
    # Please use +search+ instead.
    # ==== RESTful Web Service
    # GET /api/event_contacts/find_all_by_event_id_and_state
    # ==== Examples
    #   results = Infopark::Crm::EventContacts.find_by(:params => {:event_id => id})
    #   count = Infopark::Crm::EventContacts.find_by(:params => {:event_id => id}).size
    def self.find_by(options)
      deprecated('EventContact.find_by', 'please use EventContact.search')
      get_with_continuation(:find_all_by_event_id_and_state, options)
    end

    # ==== DEPRECATED
    # Please use +search+ instead.
    # ==== RESTful Web Service
    # GET /api/event_contacts/find_by_event_id_and_contact_id
    # ==== Examples
    #   result = Infopark::Crm::EventContacts.find_by_event_id_and_contact_id(e_id, c_id))
    def self.find_by_event_id_and_contact_id(event_id, contact_id)
      deprecated('EventContact.find_by_event_id_and_contact_id', 'please use EventContact.search')
      find(:find_by_event_id_and_contact_id, :params => {:event_id => event_id, :contact_id => contact_id})
    end

  end
end; end; end
