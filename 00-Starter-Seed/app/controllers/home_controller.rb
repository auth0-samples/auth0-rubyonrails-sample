class HomeController < ApplicationController
  def show
  end
  
  def login
    request_params = {
      client: Rails.application.secrets.auth0_client_id,
      redirect_uri: Rails.application.secrets.auth0_callback_url
    }
    url = URI::HTTPS.build(host: Rails.application.secrets.auth0_domain, path: '/login', query: to_query(request_params))
    redirect_to url.to_s
  end

  private

  def to_query(hash)
    hash.map { |k, v| "#{k}=#{URI.escape(v)}" unless v.nil? }.reject(&:nil?).join('&')
  end
end
