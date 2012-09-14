## Version 1.0.0 - 2012-09-14
* Enabled support for `event.custom_attributes`
* Removed deprecated functions `EventContact.find_by` and `EventContact.find_by_event_id_and_contact_id`. Please user `EventContact.search` instead.
* Removed `configuration.debug`.
* Renamed `Infopark::Crm::AuthenticationFailed` to `Infopark::Crm::Errors::AuthenticationFailed`.
* Merged `Infopark::Crm::Core::Base` and `Infopark::Crm::Resource` into `Infopark::Crm::Core:Resource`.

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
* Attribute names may have changed. For new attributes please refer to [Web Services API documentation](http://kb.infopark.de/crm-api).
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
