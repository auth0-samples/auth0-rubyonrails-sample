class Auth0Controller < ApplicationController
  include ApplicationHelper

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

  def logout
    if session[:userinfo].present? then
      session.delete(:userinfo)
    end
    redirect_to sprintf("https://%s/v2/logout?federated&returnTo=%s",ENV["AUTH0_DOMAIN"],request.base_url)  
  end

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

  # if user authentication fails on the provider side OmniAuth will redirect to /auth/failure,
  # passing the error message in the 'message' request param.
  def failure
    @error_msg = request.params['message']
  end
end
