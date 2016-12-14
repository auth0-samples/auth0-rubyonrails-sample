# Ruby on Rails SSO Sample

## Description
The purpose of this sample is to give you an example for how to implement Single Sign On with two different Ruby on Rails applications.

## Instructions to recreate this sample

### Configure Clients in Auth0
1. Login to https://manage.auth0.com
  1. Signup for account if you don’t have one yet
  1. Create a new client (you will automatically be directed there if just signing up)
    1. Choose the “Regular Web App” option for the client, and click Create
    1. Choose the “Ruby on Rails” option
    1. Click “Download”
    1. Unzip the downloaded bundle into a directory called `rubysso1` 
  1. Now Create a second client by clicking “Create Client” from the clients page
    1. Choose the “Regular Web App” option for the client, and click Create
    1. Choose the “Ruby on Rails” option
    1. Click “Download”
    1. Unzip the downloaded bundle into a directory called `rubysso2`

### Update the quickstart applications
1. You should now have two bundles in their own directories on your filesystem.
1. For `rubysso1` follow [these instructions](https://github.com/auth0-samples/auth0-rubyonrails-sample/tree/master/01-Login)
1. For the second application do the same, but when launching the application, make sure you specify the port `rails s -p 4000`
1. Test out both apps.  They should both request login when you go to them regardless of whether you have logged into one or the other.

### Add the SSO endpoint to both apps
1. Open https://manage.auth0.com
1. On each client, go to the settings and make sure the option for `Use Auth0 instead of the IdP to do Single Sign On` is turned on.  Please view [here](https://auth0.com/docs/sso#using-social-identity-providers) for caveats to SSO. 

### Enable SSO in each application
For this section we will be roughly following [this doc](https://auth0.com/docs/sso/regular-web-apps-sso)

1. Change the dashboard so we know which app we are in.  In `app/views/dashboard/show.html.erb` change:
    ```html
   <h1>You are in :)</h1>
    ```
    to:
    ```html
   <h1>You are in :) app 1</h1>
    ```
    and:
    ```html
   <h1>You are in :) app 2</h1>
    ```
    
1. Create a helper function for getting the Auth URL for SSO.  In `app/helpers/application_helper.rb`:
    ```ruby
  module ApplicationHelper
      def getAuthUrl(connection: 'Username-Password-Authentication')
          return sprintf("/auth/auth0?connection=%s",connection)    
      end
  end
    ```
1. Enable the auth0_controller to use the helper method. In `app/controllers/auth0_controller.rb`:
    ```ruby
  class Auth0Controller < ApplicationController
    include ApplicationHelper
    ```
1. Change the auth0_controller callback method by making it have the ability to use a session variable for the target_url.  In `app/controllers/auth0_controller.rb`:
    ```ruby
  def callback
    # OmniAuth places the User Profile information (retrieved by omniauth-auth0) in request.env['omniauth.auth'].
    # In this tutorial, you will store that info in the session, under 'userinfo'.
    # If the id_token is needed, you can get it from session[:userinfo]['credentials']['id_token'].
    # Refer to https://github.com/auth0/omniauth-auth0#auth-hash for complete information on 'omniauth.auth' contents.
    session[:userinfo] = request.env['omniauth.auth']


    if session[:target_url].present? then
      redirect_to session[:target_url]
      session.delete(:target_url)
    else
      redirect_to '/dashboard'
    end
  end
    ```
1.  Add the sso action to the auth0_controller.  In `app/controllers/auth0_controller.rb`:
    ```ruby
  def sso
    if request.params['target_url'].present? then
      # should actually constrain this to make sure it is a local redirect?  Or only expected redirects.
    else
      redirect_to '/auth/failure?message=target_url is required for this endpoint'
      return
    end
    if not request.params['connection'].present? then
      redirect_to '/auth/failure?message=connection is required for this endpoint'
      return
    end


    if session[:userinfo].present? then
      # User is already logged in, just redirect
      redirect_to params['target_url']
    else 
      session[:target_url] = request.params['target_url']
      # Redirect to login 
      redirect_to getAuthUrl(connection: request.params['connection'])
    end
  end
    ```
1. Add in the route to the new sso action.  In `config/routes.rb`:
    ```ruby
    get '/auth/sso' => 'auth0#sso'
    ```
1. Change the secured concern to use the SSO link instead of just redirecting back to the home page.  In `app/controllers/concerns/secured.rb`:
    ```ruby
  module Secured
    extend ActiveSupport::Concern
    include ApplicationHelper

    included do
      before_action :logged_in_using_omniauth?
    end

    def logged_in_using_omniauth?
      redirect_to getAuthUrl() unless session[:userinfo].present?
    end
  end
    ```
1. Add a button to refer back to the other app.  In `app/views/dashboard/show.html.erb`:
    In app1:
    ```html
    <a class="btn btn-success btn-lg" href="http://localhost:4000/auth/sso?connection=Username-Password-Authentication&target_url=/dashboard">Open App2</a>
    ```
    In app2:
    ```html
    <a class="btn btn-success btn-lg" href="http://localhost:3000/auth/sso?connection=Username-Password-Authentication&target_url=/dashboard">Open App1</a>
    ```
1. You should now be able to hop between the apps without logging back in!

### Add a logout button
1. Configure the tenant in Auth0 to support logout:
  1. Open the [dashboard](https://manage.auth0.com) 
  1. Click account settings from the drop-down in the upper right
  1. Click Advanced and then add the home pages for the apps to the allowed logout URLs: `http://localhost:3000,http://localhost:4000`
  1. Click Save
1. Configure the applications to support logout:
  1. Add a logout route.  In `config/routes.rb`:

      ```ruby
    get '/auth/logout' => 'auth0#logout'
      ```
  1. Add the logout action to the auth0 controller.  In `app/controllers/auth0_controller.rb`:

      ```ruby
      def logout
        if session[:userinfo].present? then
          session.delete(:userinfo)
        end
        redirect_to sprintf("https://%s/v2/logout?federated&returnTo=%s",ENV["AUTH0_DOMAIN"],request.base_url)  
      end
      ```
  1. Add the logout button to the dashboard page.  In `app/views/dashboard/show.html.erb`:

      ```html
  <a class="btn btn-success btn-lg" href="/auth/logout">Logout</a>
      ```

## Instructions to run this sample

### Pre-requirements
Install Ruby 2.3.1+
Install Rails 5.0.0.1+

### Configure your clients
1. Login to https://manage.auth0.com
  1. Signup for account if you don’t have one yet
  1. Create a new client
    1. Name: Ruby SSO 1 
    1. Set the type to "Regular Web App"
    1. Add `http://localhost:3000/auth/auth0/callback` to the Allowed Callback URLs section
    1. Ensure the `Use Auth0 instead of the IdP to do Single Sign On` is turned on
    1. Click Save Settings
  1. Create a second new client
    1. Name: Ruby SSO 2 
    1. Set the type to "Regular Web App"
    1. Add `http://localhost:4000/auth/auth0/callback` to the Allowed Callback URLs section
    1. Ensure the `Use Auth0 instead of the IdP to do Single Sign On` is turned on
    1. Click Save Settings
  1. Select `Account Settings` from the dropdown in the upper right where your account tenant name is.
    1. In the Advanced section, add `http://localhost:3000,http://localhost:4000` to your allowed logout urls
    1. Click Save

### Download and setup the app
1. Clone this repo
2. Create .env files in each of `rubysso1` and `rubysso2`.  The env files should look like this:
   For rubysso1:
    ```
AUTH0_CLIENT_ID=<put your client ID here for rubysso1>
AUTH0_CLIENT_SECRET=<put your client secret here for rubysso1>
AUTH0_DOMAIN=<your auth0 account>.auth0.com
AUTH0_CALLBACK_URL=http://localhost:3000/auth/auth0/callback    
    ```
   For rubysso2:
    ```
AUTH0_CLIENT_ID=<put your client ID here for rubysso2>
AUTH0_CLIENT_SECRET=<put your client secret here for rubysso2>
AUTH0_DOMAIN=<your auth0 account>.auth0.com
AUTH0_CALLBACK_URL=http://localhost:4000/auth/auth0/callback    
    ```

### Run the apps
1. From the rubysso1 directory, call `rails s`
1. From the rubysso2 directory, call `rails s -p 4000`
1. Open a browser to `http://localhost:3000`
1. Click Login
1. Click Sign-up (if you have no users in your account yet), or login
1. Once you see the dashboard, you have a button to open app2.  You should be able to click the buttons to navigate back and forth between the apps without logging back in.
1. If you do not logout before closing your browser, you should be able to navigate back to `http://localhost:3000/dashboard` without logging back in.  Or if you go to `http://localhost:3000/` you can click Login, and then you should be prompted to do a one-click login.





