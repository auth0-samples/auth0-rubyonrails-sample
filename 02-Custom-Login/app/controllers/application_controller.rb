# frozen_string_literal: true
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  attr_reader :client

  def client
    creds = { client_id: ENV['AUTH0_CLIENT_ID'],
              client_secret: ENV['AUTH0_CLIENT_SECRET'],
              api_version: 1,
              domain: ENV['AUTH0_DOMAIN'] }

    @client = Auth0Client.new(creds)
  end
end
