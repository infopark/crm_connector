# encoding: utf-8

require 'backports'
require_relative '../test_helper'

module Infopark; module Crm

  class ContactPasswordTest < ConnectorTestCase

    def setup
      # cannot re-use the same contact since multiple password requests fail
      @contact = Contact.create({
          :login => "password" + SecureRandom.hex(16),
          :last_name => 'Passwort',
          :language => 'de',
          :gender => 'M',
          :email => 'success@simulator.amazonses.com',
          :want_geo_location => false
          })
    end

    def teardown
      WebMock.disable!
    end

    # make sure to add password-request@infopark.net to the "Valid E-Mail Senders".
    # only the support can edit this.
    def test_request_a_new_password_should_be_successful
      assert_kind_of String, @contact.password_request
    end

    def test_request_a_new_password_asking_for_token_should_give_token
      result = @contact.password_request(:params => {:only_get_token => true})
      assert_kind_of String, result
      assert_match(/[0-9a-f]{30,200}/, result)
    end

    def test_password_set_sends_password_in_post_body_only
      WebMock.enable!
      stub_request(:post, %r{https?://.*/api/contacts/password_set[^X]*$}).
        with(:body => {
            'password' => 'the_X_password',
            'token' => 'a_token'
            }).to_return(:status => 200, :body => '{}', :headers => {})
      Contact.password_set('the_X_password', 'a_token')
    end

    def test_authenticate_sends_password_in_post_body_only
      WebMock.enable!
      stub_request(:post, %r{https?://.*/api/contacts/authenticate[^X]*$}).
        with(:body => {
            'login' => 'the_X_login',
            'password' => 'the_password'
            }).to_return(:status => 200, :body => '{"id":"12345678"}', :headers => {})
      stub_request(:get, %r{https?://.*/api/contacts/12345678.json}).
        to_return(:status => 200, :body => '{"account_id":"33221","country":null,"id":"12345678"}', :headers => {})
      Contact.authenticate('the_X_login', 'the_password')
    end

    def test_password_request_sends_params_in_post_body_only
      WebMock.enable!
      stub_request(:post, %r{https?://.*/api/contacts/.*/password_request[^X]*$}).
        with(:body => {
            'only_get_token' => true,
            }).to_return(:status => 200, :body => '{"password_request_token":"332211"}', :headers => {})
      @contact.password_request({:params => {:only_get_token => true}})
    end

    def test_authenticate_with_correct_credencials_should_succeed
      token = @contact.password_request(:params => {:only_get_token => true})
      eventually do
        Contact.password_set('correct_password', token)
      end

      result = Contact.authenticate(@contact.login, 'correct_password')
      assert_kind_of Contact, result
      assert_match @contact.id, result.id
    end

    def pending_test_set_a_new_password_should_fail_with_empty_password
      assert_raise(ActiveResource::ResourceNotFound) {
          Contact.password_set('', 'invalid_token')
          }
    end

    # @webcrm_todo currently: 500 on server
    def pending_test_set_a_new_password_should_fail_with_wrong_token
      assert_raise(ActiveResource::ResourceNotFound) {
          Contact.password_set('my_password', 'invalid_token')
          }
    end

    def test_set_a_new_password_should_succeed_with_given_login
      token = @contact.password_request(:params => {:only_get_token => true})
      result = nil
      eventually do
        result = Contact.password_set('my_funky_password', token)
      end
      assert_kind_of String, result
    end

  end

end; end
