require "auth0"

class HomeController < ApplicationController
  attr_reader :client

  def auth
    v2_creds = { client_id: ENV['AUTH0_CLIENT_ID'],
     token: '',
     api_version: 2,
     domain: ENV['AUTH0_DOMAIN'] }

    @client = Auth0Client.new(v2_creds)

    begin
      if params[:signup]
        signup
      end
      login
      redirect_to '/dashboard'
    rescue Auth0::Unauthorized
      redirect_to '/', notice: 'Invalid email or password'
    rescue => ex
      redirect_to '/', notice: ex.message
    end
  end

  private

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
    client.signup(
      params[:user],
      params[:password]
    )
  end
end
