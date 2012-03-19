module Infopark; module Crm; module Default
  class Event < Resource
    ##
    # :singleton-method: search
    # ==== RESTful Web Service
    # GET /api/events/search
    # ==== Examples
    #   results = Infopark::Crm::Event.search(:params => {:kind => kind})
    #   results = Infopark::Crm::Event.search(:params => {:event_set => event_set})
    #   results = Infopark::Crm::Event.search(:params => {:q => 'full-text search'})
    has_search

    self.schema = {
      :details => :string,
      :dtend_at => :time,
      :dtstart_at => :time,
      :event_set => :string,
      :kind => :string,
      :location => :string,
      :title => :string,
    }
  end
end; end; end
