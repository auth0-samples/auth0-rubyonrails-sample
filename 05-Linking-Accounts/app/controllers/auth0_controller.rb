# frozen_string_literal: true
class Auth0Controller < ApplicationController
  def callback
    # OmniAuth places the User Profile information (retrieved by omniauth-auth0) in request.env['omniauth.auth'].
    # In this tutorial, you will store that info in the session, under 'userinfo'.
    # If the id_token is needed, you can get it from session[:userinfo]['credentials']['id_token'].
    # Refer to https://github.com/auth0/omniauth-auth0#auth-hash for complete information on 'omniauth.auth' contents.
    unless session[:userinfo].present?
      session[:userinfo] = request.env['omniauth.auth']
      redirect_to '/dashboard'
      return
    end
    session[:linkuserinfo] = request.env['omniauth.auth']
    redirect_to '/settings/link_provider'
  end

  # if user authentication fails on the provider side OmniAuth will redirect to /auth/failure,
  # passing the error message in the 'message' request param.
  def failure
    @error_msg = request.params['message']
  end
end
