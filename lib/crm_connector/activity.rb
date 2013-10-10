require 'ostruct'

module Infopark; module Crm
  class Activity < Core::Resource

    ##
    # @!method self.search(input)
    # Searches for activities
    # @param input [Hash] A hash containing a +params+ key. The value of this key is a hash containing the actual search query.
    # @return [Array<Infopark::Crm::Activity>]
    # @webcrm_rest_url <code>GET /api/activities/search</code>
    # @example
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
      :comment_attachments => :array,
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

    ##
    # Queries the WebCRM for the Contact with the id +contact_id+.
    # @return [Infopark::Crm::Contact] The contact associated with this activity, if +contact_id+ is present.
    # @webcrm_rest_url <code>GET /api/contacts/_contact_id_</code>
    def contact
      Infopark::Crm::Contact.find(contact_id) if contact_id
    end

    ##
    # Queries the WebCRM for the Account with the id +account_id+.
    # @return [Infopark::Crm::Account] The account associated with this activity, if +account_id+ is present.
    # @webcrm_rest_url <code>GET /api/accounts/_account_id_</code>
    def account
      Infopark::Crm::Account.find(account_id) if account_id
    end

    ##
    # Queries the WebCRM for the CustomType with the id +kind+.
    # @return [Infopark::Crm::CustomType] The custom type associated with this activity, if +kind+ is present.
    # @webcrm_rest_url <code>GET /api/custom_types/_kind_</code>
    def custom_type
      Infopark::Crm::CustomType.find(kind) if kind
    end


    class Comment < Core::Resource
      self.schema = {
        :contact_id => :string,
        :notes => :string,
        :attachments => :array,
        :published => :boolean,
        :updated_at => :time,
        :updated_by => :string,
      }
    end
  end
end; end
