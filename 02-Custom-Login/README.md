# Custom Login
[Full Tutorial](https://auth0.com/docs/quickstart/webapp/rails/02-custom-login)

This example shows how to add login and signup capabilities to your Rails application without using neither the Auth0 Lock widget and nor OmniAuth. Using the Auth0 Ruby SDK and a custom form, we can easily add authentication.

## Running the Sample Application
In order to run the example you need to have ruby installed.

You also need to set the ClientSecret, ClientId, Domain and CallbackURL for your Auth0 app as environment variables with the following names respectively: `AUTH0_CLIENT_SECRET`, `AUTH0_CLIENT_ID`, `AUTH0_DOMAIN` and `AUTH0_CALLBACK_URL`.

For that, if you just create a file named `.env` in the project directory and set the values as follows, the app will just work:

````bash
# .env file
AUTH0_CLIENT_SECRET=myCoolSecret
AUTH0_CLIENT_ID=myCoolClientId
AUTH0_DOMAIN=samples.auth0.com
AUTH0_CALLBACK_URL=http://localhost:3000/auth/auth0/callback
````
Once you've set those 4 environment variables, run `bundle install` and then `rails s`. Now, browse [http://localhost:3000/](http://localhost:3000/).

Shut it down manually with Ctrl-C.

__Note:__ If you are using Windows, uncomment the `tzinfo-data` gem in the gemfile.

## Important Snippets
### 1. Initialize the API Client Instance
```ruby
def client
  creds = { client_id: ENV['AUTH0_CLIENT_ID'],
    client_secret: ENV['AUTH0_CLIENT_SECRET'],
    api_version: 1,
    domain: ENV['AUTH0_DOMAIN'] }

  @client = Auth0Client.new(creds)
end
```

### 2. Create the Authentication Action in the Auth0 Controller
```ruby
def callback
  begin
      if params[:signup]
        signup
      end
      session[:token_id] = login
    end
    redirect_to '/dashboard'
  rescue Auth0::Unauthorized
    redirect_to '/', notice: 'Invalid email or password'
  rescue => ex
    redirect_to '/', notice: ex.message
  end
end

def failure
  @error_msg = request.params['message']
end

def login
  token = client.login(
    params[:user],
    params[:password],
    authParams: {
     scope: 'openid name email'
    },
    connection:'Username-Password-Authentication'
  )

  session[:token_id] = token
end

def signup
  token = client.signup(
    params[:user],
    params[:password]
  )
end
```

### 3. Check if  User is Authenticated in Secured Controller
```ruby
#Note: Controllers with secured actions will need to inherit from Secured Controller.
class SecuredController < ApplicationController
  before_action :logged_in?

  private

  def logged_in?
    unless session[:token_id].present?
      redirect_to '/'
    end
  end
end
```

## Used Libraries
* [Auth0 Lock](https://github.com/auth0/lock)
* [Auth0 Ruby SDK](https://github.com/auth0/ruby-auth0)
