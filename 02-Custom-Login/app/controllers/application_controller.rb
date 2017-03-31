# frozen_string_literal: true
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  attr_reader :client

  def client
    creds = { client_id: Rails.application.secrets.auth0_client_id,
              client_secret: Rails.application.secrets.auth0_client_secret,
              domain: Rails.application.secrets.auth0_domain,
              token: Rails.application.secrets.auth0_token }
    @client ||= Auth0Client.new(creds)
  end
end
