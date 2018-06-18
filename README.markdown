# Infopark WebCRM Connector

[![Build Status](https://travis-ci.org/infopark/crm_connector.png?branch=master)](https://travis-ci.org/infopark/crm_connector)

Infopark WebCRM Connector is the official Ruby SDK for [Infopark WebCRM](http://www.infopark.de/webcrm) API v1. It basically wraps the [WebCRM web services API](http://kb.infopark.de/crm-api) using [Active Resource](http://rubydoc.info/gems/activeresource/).

**API v1 is the old API. For API v2 please refer to the [Infopark WebCRM SDK](https://github.com/infopark/webcrm_sdk). It is highly recommended to upgrade to WebCRM SDK.**

Currently, the latest version of Active Resource 4 with Ruby 2.4.4 is tested and supported. It is not planned to ever support Active Resource 5.

# Installation

Add `infopark_crm_connector` to your `gemfile`:

    gem 'infopark_crm_connector'

Install the gem with [Bundler](http://gembundler.com/):

    bundle install

# Configuration

    require 'infopark_crm_connector'

    Infopark::Crm.configure do |configuration|
      configuration.url = "https://webcrm.server/url"
      configuration.login = "webcrm_user"
      configuration.api_key = "api_key_of_webcrm_user"
    end

See {Infopark::Crm.configure} for a complete list of configuration keys.

# Example Usage

This Ruby SDK provides the WebCRM's domain models {Infopark::Crm::Account Account}, {Infopark::Crm::Activity Activity}, {Infopark::Crm::Contact Contact}, {Infopark::Crm::Event Event}, {Infopark::Crm::Mailing Mailing}, among others. All domain models are subclasses of {Infopark::Crm::Core::Resource} which itself inherits from {ActiveResource::Base} and provides methods such as `find(id)`, `create(hash)`, `update(hash)`, `search(params)` and others.

## Contact
    # Retrieve the contact identified by the login 'root'
    contact = Infopark::Crm::Contact.search(:params => {:login => 'root'}).first

    # Change this contact's mail address
    contact.update_attribute(:email, 'root@example.com')

    # Send a new password request mail to the contact's address
    contact.password_request

## Activity

    # Create a new activity kind
    Infopark::Crm::CustomType.create(:name => 'support-case', :kind => 'Activity',
        :states => ['created'])

    # Create a new activity
    activity = Infopark::Crm::Activity.new(:kind => 'support-case')

    # Set properties of this activity
    activity.title = 'Sprechen Sie Deutsch?'

    # Switch to a different request locale
    Infopark::Crm.configure {|c| c.locale = 'de'}

    # Post the activity (which is going to fail)
    activity.save
    # => false

    # Get to know what's missing
    activity.errors.to_hash
    # => {:state=>["ist kein gültiger Wert"]}

# Contributing

We no longer accept contributions for this repo. Please consider upgrading to [Infopark WebCRM SDK](https://github.com/infopark/webcrm_sdk) which is a client for API v2.

## Build and install gem

    bundle exec rake gem     #build
    bundle exec rake install #build and install

## Documentation

    bundle exec rake yard
    open doc/index.html

# Changelog

## Version 1.3.0 - 2017-07-15
* Removed support for ActiveResource 3.x. ActiveResource 4.x is supported only.
* CRM Connector is deprecated in favor of [WebCRM SDK (API v2)](https://github.com/infopark/webcrm_sdk)

## Version 1.2.0 - 2014-03-26
* Added support for ActiveResource 4.0.
* Remove support for Ruby 1.8.

## Version 1.1.0 - 2013-10-21
* Remove support for ActiveResource 3.0.
* Added `Attachment.upload_permission`, `Attachment.download_url` and the activity comment property `attachments`. See [API documentation](https://dev.infopark.net/26635f6d056215c9/attachments)

## Version 1.0.1 - 2013-03-20
* Added continuous integration of travis-ci.org (see [travis-ci.org/infopark/crm_connector](https://travis-ci.org/infopark/crm_connector/))
* Bugfix: Default attributes are inherited to subclasses (fixes [Issue #1](https://github.com/infopark/crm_connector/issues/1))
* Bugfix: Infopark CRM Connector in combination with ActiveResource 3.0 used XML. Now it uses JSON.

## Version 1.0.0 - 2012-09-14
* Enabled support for `event.custom_attributes`
* Removed deprecated functions `EventContact.find_by` and `EventContact.find_by_event_id_and_contact_id`. Please use `EventContact.search` instead.
* Removed `configuration.debug`.
* Renamed `Infopark::Crm::AuthenticationFailed` to `Infopark::Crm::Errors::AuthenticationFailed`.
* Merged `Infopark::Crm::Core::Base` and `Infopark::Crm::Resource` into `Infopark::Crm::Core:Resource`.
* Removed all `Infopark::Crm::Default::*` classes.

## Version 0.9.2 - 2012-03-19
* Security improvement for `Contact.authenticate`, `Contact.password_set` and `contact.password_request`

## Version 0.9.1 - 2012-02-28
* Removed `Diary`. Please use `Activity` instead.
* Added `Mailing`
* Added `appointment_*` and `task_*` fields to `Activity`
* Added `role_names` field to `Contact`
* Added `tags` field to `Activity`, `Account` and `Contact`

## Version 0.9 - 2012-01-27
Initial Release of Infopark CRM Connector

### Changes from OMC Connector to CRM Connector
* Namespace changed from `OmcConector::` to `Infopark::Crm::`
* Attribute names may have changed. For new attributes please refer to the [Web Services API documentation](http://kb.infopark.de/crm-api).
* Works only with Infopark WebCRM.

#### Changed configuration
* `live_server_groups_callback` - replaces `contact_roles_callback`

#### New classes
* `CustomType`
* `Role`
* `System`

#### New methods
* `Account.search`
* `Activity.search`
* `Contact.search`
* `Event.search`
* `EventContact.search`
* `contact.live_server_groups` - replaces `contact.roles`

#### Removed classes
* `AccountCollection`
* `InquiryKind` - use `CustomType`
* `InquiryLink`
* `Inquiry` - use `Activity`
* `Location` - use `contact` and `account` properties
* `Mailing`
* `RegistrationInquiry`
* `Session`


#### Removed methods
* `account.contacts` - use `Contact.search(:params => {:acount_id => acount_id})`
* `Account.find_by_name` - use `Account.search`
* `account.inquiries` - use `Activity.search(:params => {:account_id => account_id})`
* `account.locations`
* `contact.account_activities` - use `Activity.search(:query => {:account_id => account_id})`
* `contact.activities` - use `Activity.search(:params => {:contact_id => contact_id})`
* `contact.create_activity`
* `contact.create_diary`
* `contact.create_location_with_account_association`
* `contact.create_location`
* `contact.create_registration_request`
* `contact.event_participation`
* `contact.find_activity`
* `Contact.find_by_email` - use `Contact.search(:params => {:email => email})`
* `Contact.find_by_login` - use `Contact.search(:params => {:login => login})`
* `Contact.languages`
* `contact.location`
* `Contact.lookup_uptions`
* `contact.move_location`
* `contact.roles` - use `contact.live_server_groups`
* `contact.serialized_attributes` - use `contact.attributes`
* `contact.subscriptions`
* `Contact.titles`
* `contact.update_location`
* `contact.update_subscriptions`
* `contact.validate_login` - use `Contact.search(:params => {:login => login})`
* `event.attend(!)`
* `event.contacts` - use `EventContact.search(:event_id => event_id)`
* `Event.find_by_name`
* `event.inquire(!)`
* `event.refuse(!)`
* `event.register(!)`
* `event_contact.attend` - use `event_contact.status = 'attended'`
* `event_contact.inquire` - use `event_contact.status = 'unregistered'`
* `event_contact.refuse` - use `event_contact.status = 'refused'`
* `event_contact.register` - use `event_contact.status = 'registered'`
* `event_contact.update_details`
* `inquiry.create_diary`
* `inquiry.create_link`
* `inquiry.diaries`
* `inquiry.links`

# License

Copyright (c) 2009 - 2013 Infopark AG (http://www.infopark.com)

This software can be used and modified under the LGPLv3. Please refer to http://www.gnu.org/licenses/lgpl-3.0.html for the license text.
