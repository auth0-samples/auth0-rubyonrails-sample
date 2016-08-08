# Linking Accounts
[Full Tutorial](https://auth0.com/docs/quickstart/webapp/rails/05-linking-accounts)

This example shows how to link/unlink different Auth0 users accounts.

## Running the Sample Application
In order to run the example you need to have ruby installed.

You also need to set the ClientSecret, ClientId, Domain and CallbackURL for your Auth0 app as environment variables with the following names respectively: `AUTH0_CLIENT_SECRET`, `AUTH0_CLIENT_ID`, `AUTH0_DOMAIN` and `AUTH0_CALLBACK_URL`.

Set the environment variables in `.env` to match those your Auth0 Client.

````bash
# .env file
AUTH0_CLIENT_ID=myCoolClientId
AUTH0_CLIENT_SECRET=myCoolSecret
AUTH0_DOMAIN=samples.auth0.com
AUTH0_CALLBACK_URL=http://localhost:3000/auth/auth0/callback
````
Once you've set those 4 environment variables, run `bundle install` and then `rails s`. Now, browse [http://localhost:3000/](http://localhost:3000/).
__Note:__ Remember that you need to have `./bin` in your path for `rails s` to work.

Shut it down manually with Ctrl-C.

__Note:__ If you are using Windows, uncomment the `tzinfo-data` gem in the gemfile.

## Important Snippets

### 1. Auth0 Lock Account Linking Setup
[Home View Javascript Code](/05-linking-Accounts/app/assets/javascripts/home.js.erb)
```js
function linkPasswordAccount(){
	connection = $("#link_provider").val();
	var linkOptions = {
		auth: {
			redirectUrl: '<%= Rails.application.secrets.auth0_callback_url %>',
			allowLogin: true
		},
		languageDictionary: {
			title: 'Link another account'
		}
	};
	if (connection){
		linkOptions.allowedConnections = [connection];
	}
	var linkLock = new Auth0Lock('<%= Rails.application.secrets.auth0_client_id %>', '<%= Rails.application.secrets.auth0_domain %>', linkOptions);

	//open lock in signin mode, with the customized options for linking
	linkLock.show();
}
```
### 2. Auth0 Client Helpers
[Auth0 Client Helper Code](/05-linking-Accounts/app/helpers/client_helper.rb)
```ruby
module ClientHelper
  def self.client_user(user)
    creds = { client_id: Rails.application.secrets.auth0_client_id,
              token: user[:credentials][:token],
              api_version: 2,
              domain: Rails.application.secrets.auth0_domain }

    Auth0Client.new(creds)
  end

  def self.client(user)
    creds = { client_id: Rails.application.secrets.auth0_client_id,
              token: user[:credentials][:id_token],
              api_version: 2,
              domain: Rails.application.secrets.auth0_domain }

    Auth0Client.new(creds)
  end

  def self.client_admin
    creds = { client_id: Rails.application.secrets.auth0_client_id,
              token: Rails.application.secrets.auth0_master_jwt,
              api_version: 2,
              domain: Rails.application.secrets.auth0_domain }
    Auth0Client.new(creds)
  end
end
```

### 3. Settings Controller Methods
[Settings Controller Code](/05-linking-Accounts/app/controllers/settings_controller.rb)

```ruby
def show
	@user = session[:userinfo]
	@unlink_providers = unlink_providers.keys - [user[:provider]]
	@providers = link_providers - @unlink_providers - [user[:provider]]
end

def link_provider
	@user = session[:userinfo]
	link_user = session[:linkuserinfo]
	ClientHelper.client(user).link_user_account(user['uid'], link_with: link_user[:credentials][:id_token])
	redirect_to '/settings', notice: 'Provider succesfully linked.'
end

def unlink_provider
	@user = session[:userinfo]
	unlink_user_id = unlink_providers[params['unlink_provider']]
	ClientHelper.client(user).unlink_users_account(user['uid'], params['unlink_provider'], unlink_user_id)
	redirect_to '/settings', notice: 'Provider succesfully unlinked.'
end

private

def unlink_providers
	user_info = ClientHelper.client_user(user).user_info
	Hash[user_info['identities'].collect { |identity| [identity['provider'], identity['user_id']] }]
end

def link_providers
	connections = ClientHelper.client_admin.connections
	connections.map do |connection|
		connection['strategy'] if connection['enabled_clients'].include?(Rails.application.secrets.auth0_client_id)
	end.compact
end
```

## Used Libraries
* [Auth0 Lock](https://github.com/auth0/lock)
* [OmniAuth](https://github.com/intridea/omniauth)
* [OmniAuth Auth0 Strategy](https://github.com/auth0/omniauth-auth0)
* [OmniAuth Oauth2](https://github.com/intridea/omniauth-oauth2)
