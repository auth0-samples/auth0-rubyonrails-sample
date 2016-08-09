# frozen_string_literal: true
module ClientHelper
  def self.client_user(user)
    creds = { client_id: Rails.application.secrets.auth0_client_id,
              token: user[:credentials][:token],
              api_version: 2,
              domain: Rails.application.secrets.auth0_domain }

    Auth0Client.new(creds)
  end

  def self.client(user)
    creds = { client_id: Rails.application.secrets.auth0_client_id,
              token: user[:credentials][:id_token],
              api_version: 2,
              domain: Rails.application.secrets.auth0_domain }

    Auth0Client.new(creds)
  end

  def self.client_admin
    creds = { client_id: Rails.application.secrets.auth0_client_id,
              token: Rails.application.secrets.auth0_master_jwt,
              api_version: 2,
              domain: Rails.application.secrets.auth0_domain }
    Auth0Client.new(creds)
  end
end
