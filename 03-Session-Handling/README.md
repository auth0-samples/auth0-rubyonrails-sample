# Session Handling
[Full Tutorial](https://auth0.com/docs/quickstart/webapp/rails/03-session-handling)

This example shows how to store session data and cleanup the session on logout in your Rails application using the Auth0 Lock widget and the OmniAuth authentication system.

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

### 1. Auth0 Lock Setup
[Home Javascript Code](/01-Login/app/assets/javascripts/home.js.erb)
```ruby
var options = {
   auth: {
 		redirectUrl: '<%= Rails.application.secrets.auth0_callback_url %>',
 		params: {
 			scope: 'openid name email picture'
 		}
   }
 };
var lock = new Auth0Lock('<%= Rails.application.secrets.auth0_client_id %>', '<%= Rails.application.secrets.auth0_domain %>', options);

function signin() {
 	lock.show();
}
```
### 2. Check if  User is Authenticated in Secured Controller Concern
[Secured Controller Concern Code](/01-Login/app/controllers/concerns/secured.rb)
```ruby
module Secured
  extend ActiveSupport::Concern

  included do
    before_action :logged_in_using_omniauth?
  end

  def logged_in_using_omniauth?
    redirect_to '/' unless session[:userinfo].present?
  end
end
```

### 3. Store User Profile Upon Successful Authentication
[Auth0 Controller Code](/01-Login/app/controllers/auth0_controller.rb)
```ruby
def callback
  # OmniAuth places the User Profile information (retrieved by omniauth-auth0) in request.env['omniauth.auth'].
  # In this tutorial, you will store that info in the session, under 'userinfo'.
  # If the id_token is needed, you can get it from session[:userinfo]['credentials']['id_token'].
  # Refer to https://github.com/auth0/omniauth-auth0#auth-hash for complete information on 'omniauth.auth' contents.
  session[:userinfo] = request.env['omniauth.auth']

  redirect_to '/dashboard'
end

# if user authentication fails on the provider side OmniAuth will redirect to /auth/failure,
# passing the error message in the 'message' request param.
def failure
  @error_msg = request.params['message']
end
```

### 4. Logout
[Logout Controller Code](/01-Login/app/controllers/logout_controller.rb)
```ruby
def logout
  reset_session
  redirect_to logout_url.to_s
end
```

### 5. Logout Helper
[Logout Helper Code](/01-Login/app/helpers/logout_helper.rb)
```ruby
def logout_url
  creds = { client_id: Rails.application.secrets.auth0_client_id,
            client_secret: Rails.application.secrets.auth0_client_secret,
            api_version: 1,
            domain: Rails.application.secrets.auth0_domain }
  client = Auth0Client.new(creds)
  client.logout_url(root_url)
end
```


## Used Libraries
* [Auth0 Lock](https://github.com/auth0/lock)
* [Auth0 Ruby SDK](https://github.com/auth0/ruby-auth0)
* [OmniAuth](https://github.com/intridea/omniauth)
* [OmniAuth Auth0 Strategy](https://github.com/auth0/omniauth-auth0)
* [OmniAuth Oauth2](https://github.com/intridea/omniauth-oauth2)
