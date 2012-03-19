module Infopark; module Crm; module Default
  class Mailing < Resource

    ##
    # :singleton-method: search
    # ==== RESTful Web Service
    # GET /api/mailing/search
    # ==== Examples
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

    # Queries the WebCRM for the Event with the id +event_id+.
    # Returns +nil+ if +event_id+ is +nil+.
    def event
      Infopark::Crm::Event.find(event_id) if event_id
    end
  end

end; end; end
