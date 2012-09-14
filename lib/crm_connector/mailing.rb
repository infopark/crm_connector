module Infopark; module Crm
  class Mailing < Core::Resource

    ##
    # @!method self.search(input)
    # Searches for mailings
    # @param input [Hash] A hash containing a +params+ key. The value of this key is a hash containing the actual search query.
    # @return [Array<Infopark::Crm::Mailing>]
    # @webcrm_rest_url <code>GET /api/mailings/search</code>
    # @example
    #   results = Infopark::Crm::Mailing.search(:params => {:event_id => event_id})
    #   results = Infopark::Crm::Mailing.search(:params => {:only_unreleased => true})
    #   results = Infopark::Crm::Mailing.search(:params => {:q => 'full-text search'})
    has_search

    self.schema = {
      :body => :string,
      :dtstart_at => :time,
      :email_from => :string,
      :email_reply_to => :string,
      :email_subject => :string,
      :event_id => :string,
      :html_body => :string,
      :mailing_type => :string,
      :title => :string,
    }

    ##
    # Queries the WebCRM for the Event with the id +event_id+.
    # @return [Infopark::Crm::Event] The event associated with this event contact, if +event_id+ is present.
    # @webcrm_rest_url <code>GET /api/events/_event_id_</code>
    def event
      Infopark::Crm::Event.find(event_id) if event_id
    end
  end

end; end
