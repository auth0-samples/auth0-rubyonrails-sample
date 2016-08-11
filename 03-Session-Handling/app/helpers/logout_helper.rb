# frozen_string_literal: true
module LogoutHelper
  def logout_url
    creds = { client_id: Rails.application.secrets.auth0_client_id,
              client_secret: Rails.application.secrets.auth0_client_secret,
              api_version: 1,
              domain: Rails.application.secrets.auth0_domain }
    client = Auth0Client.new(creds)
    client.logout_url(root_url)
  end
end
