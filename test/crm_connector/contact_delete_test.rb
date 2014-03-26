# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class ContactDeleteTest < ConnectorTestCase

    class << self
      def startup
        c = Contact.create({
            :last_name => 'Delete',
            :language => 'de',
            :gender => 'M',
            :email => 'deleteme@example.com',
            :login => "test" + SecureRandom.hex(16),
            :want_geo_location => false
            })
        c.save!
        @@contact_id = c.id
      end
    end

    def test_delete_by_id_should_be_successful
      result = Contact.delete @@contact_id
      assert_kind_of Net::HTTPOK, result
    end

  end

end; end
