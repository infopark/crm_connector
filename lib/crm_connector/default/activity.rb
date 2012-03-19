require 'ostruct'

module Infopark; module Crm; module Default
  class Activity < Resource
    ##
    # :singleton-method: search
    # ==== RESTful Web Service
    # GET /api/activity/search
    # ==== Examples
    #   results = Infopark::Crm::Activity.search(:params => {:state => 'created'})
    #   results = Infopark::Crm::Activity.search(:params => {:kind => 'support case'})
    #   results = Infopark::Crm::Activity.search(:params => {:contact_id => cid})
    #   results = Infopark::Crm::Activity.search(:params => {:account_id => aid})
    #   results = Infopark::Crm::Activity.search(:params => {:q => 'full-text search'})
    has_search

    self.schema = {
      :account_id => :string,
      :appointment_contact_id => :string,
      :appointment_dtend_at => :time,
      :appointment_dtstart_at => :time,
      :appointment_location => :string,
      :comment_notes => :string,
      :comment_published => :boolean,
      :contact_id => :string,
      :email_cc => :string,
      :kind => :string,
      :state => :string,
      :tags => :array,
      :task_due_at => :time,
      :task_owner_id => :string,
      :title => :string,
    }

    # Queries the WebCRM for the Contact with the id +contact_id+.
    # Returns +nil+ if +contact_id+ is +nil+.
    def contact
      Infopark::Crm::Contact.find(contact_id) if contact_id
    end

    # Queries the WebCRM for the Account with the id +account_id+.
    # Returns +nil+ if +account_id+ is +nil+.
    def account
      Infopark::Crm::Account.find(account_id) if account_id
    end

    # Queries the WebCRM for the CustomType with the id +kind+.
    # Returns +nil+ if +kind+ is +nil+.
    def custom_type
      Infopark::Crm::CustomType.find(kind) if kind
    end

  end
end; end; end
