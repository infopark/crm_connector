# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class ContactAuthenticationTest < ConnectorTestCase

    class << self
      def startup
        c = Contact.search(:params => {:login => 'root'}).first
        c.password_set('root')
        c.email = 'root@example.org'
        c.save
      end
    end

    def test_authenticate_with_the_correct_password_should_return_the_contact
      assert_equal 'root@example.org',
          Contact.authenticate('root', 'root').email
    end

    def test_authenticate_returns_a_complete_contact_info
      assert 30 <= Contact.authenticate('root', 'root').attributes.size, "Missing attributes"
    end

    def test_authenticate_with_the_correct_password_should_return_a_contact
      assert_kind_of Infopark::Crm::Contact, Contact.authenticate('root', 'root')
    end

    def test_authenticate_with_a_wrong_password_should_raise_an_error
      assert_raise AuthenticationFailed do
        Contact.authenticate('maja', 'wrong')
      end
    end

  end

end; end
