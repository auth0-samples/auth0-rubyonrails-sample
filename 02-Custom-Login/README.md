# Custom Login
[Full Tutorial](https://auth0.com/docs/quickstart/webapp/rails/02-custom-login)

This example shows how to add login and signup capabilities to your Rails application without using neither the Auth0 Lock widget and nor OmniAuth. Using the Auth0 Ruby SDK and a custom form, we can easily add authentication.

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
### 1. Initialize the API Client Instance
[Application Controller Code](/02-Custom-Login/app/controllers/application_controller.rb)
```ruby
def client
  creds = { client_id: Rails.application.secrets.auth0_client_id,
            client_secret: Rails.application.secrets.auth0_client_secret,
            api_version: 1,
            domain: Rails.application.secrets.auth0_domain }
  @client ||= Auth0Client.new(creds)
end
```

### 2. Authentication Methods in Auth0 Controller
[Auth0 Controller Code](/02-Custom-Login/app/controllers/auth0_controller.rb)
```ruby
def callback
  if params[:user]
    signup if params[:signup]
    session[:token_id] = login
  else
    session[:token_id] = google_login
  end
  redirect_to '/dashboard'
rescue Auth0::Unauthorized
  redirect_to '/', notice: 'Invalid email or password'
rescue => ex
  redirect_to '/', notice: ex.message
end

def google_authorize
  redirect_to client.authorization_url(
    Rails.application.secrets.auth0_callback_url,
    connection: 'google-oauth2',
    scope: 'openid'
  ).to_s
end

def login
  client.login(
    params[:user],
    params[:password],
    authParams: {
      scope: 'openid name email'
    },
    connection: 'Username-Password-Authentication'
  )
end

def signup
  client.signup(
    params[:user],
    params[:password]
  )
end
```

### 3. Check if  User is Authenticated in Secured Controller Concern
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

## Used Libraries
* [Auth0 Lock](https://github.com/auth0/lock)
* [Auth0 Ruby SDK](https://github.com/auth0/ruby-auth0)
