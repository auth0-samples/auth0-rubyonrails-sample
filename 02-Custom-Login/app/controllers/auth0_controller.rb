# frozen_string_literal: true
class Auth0Controller < ApplicationController
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
      ENV['AUTH0_CALLBACK_URL'],
      connection: 'google-oauth2',
      scope: 'openid'
    ).to_s
  end

  def failure
    @error_msg = request.params['message']
  end

  private

  def google_login
    client.obtain_user_tokens(params['code'], ENV['AUTH0_CALLBACK_URL'], 'google-oauth2', 'openid')['id_token']
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
end
