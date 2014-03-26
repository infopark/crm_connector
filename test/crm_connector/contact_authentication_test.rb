# encoding: utf-8
require_relative '../test_helper'

module Infopark; module Crm

  class ContactAuthenticationTest < ConnectorTestCase

    def test_authenticate_with_the_correct_password_should_return_the_contact
      c = Contact.search(:params => {:login => 'root'}).first
      token = c.password_request(:params => {:only_get_token => true})
      eventually do
        Contact.password_set('root', token)
      end
      c.email = 'root@example.org'
      c.save

      @authenticated_contact = Contact.authenticate('root', 'root')
      assert_kind_of Infopark::Crm::Contact, @authenticated_contact
      assert_equal 'root@example.org', @authenticated_contact.email
      assert 30 <= @authenticated_contact.attributes.size, "Missing attributes"
    end

    def test_authenticate_with_a_wrong_password_should_raise_an_error
      assert_raise Errors::AuthenticationFailed do
        Contact.authenticate('maja', 'wrong')
      end
    end

  end

end; end
