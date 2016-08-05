# User Profile
[Full Tutorial](https://auth0.com/docs/quickstart/webapp/rails/04-user-profile)

This example shows how to retrieve an Auth0 user’s profile ([normalized and full](https://auth0.com/docs/user-profile/user-profile-details)) in a Rails application using OmniAuth.

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

### 1. Store the User Profile Data Upon Successful Authentication
[Auth0 Controller Code](/04-User-Profile/app/controllers/auth0_controller.rb)
```ruby
class Auth0Controller < ApplicationController
  def callback
    session[:userinfo] = request.env['omniauth.auth']

    redirect_to '/dashboard'
  end

  def failure
    @error_msg = request.params['message']
  end
end
```

### 2. Retrieve the User Data in the Dashboard Controller
[Dashboard Controller Code](/04-User-Profile/app/controllers/dashboard_controller.rb)
```ruby
class DashboardController < ApplicationController
  include Secured
  def show
    @user = session[:userinfo]
  end
end
```

### 3. Show the User Profile in the Dashboard View
[Dashboard View Code](/04-User-Profile/app/views/dashboard/show.html.erb)
```ruby
<section class="jumbotron  text-center">
  <h2><img class="jumbo-thumbnail img-circle" src="${ '<%= @user[:info][:image] %>' }"/></h2>
  <h1>Welcome, ${ '<%= @user[:info][:name] %>' }</h1>
</section>
<section class="container">
  <div class="panel panel-default">
    <div class="panel-heading">Normalized User Profile</div>
    <div class="panel-body">
      <pre>${ '<%= JSON.pretty_generate(@user[:info]) %>' }</pre>
    </div>
  </div>
  <div class="panel panel-default">
    <div class="panel-heading">Full User Profile</div>
    <div class="panel-body">
      <pre>${ '<%= JSON.pretty_generate(@user[:extra][:raw_info]) %>' }</pre>
    </div>
  </div>
</section>
```

## Used Libraries
* [Auth0 Lock](https://github.com/auth0/lock)
* [OmniAuth](https://github.com/intridea/omniauth)
* [OmniAuth Auth0 Strategy](https://github.com/auth0/omniauth-auth0)
* [OmniAuth Oauth2](https://github.com/intridea/omniauth-oauth2)
