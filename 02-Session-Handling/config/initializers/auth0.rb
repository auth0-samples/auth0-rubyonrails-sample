# frozen_string_literal: true
Rails.application.config.middleware.use OmniAuth::Builder do
  params = {
    scope: 'openid profile'
  }
  unless ENV['AUTH0_AUDIENCE'].blank?
    params.audience = ENV['AUTH0_AUDIENCE']
  end

  provider(
    :auth0,
    ENV['AUTH0_CLIENT_ID'],
    ENV['AUTH0_CLIENT_SECRET'],
    ENV['AUTH0_DOMAIN'],
    callback_path: '/auth/auth0/callback',
    authorize_params: params
  )
end
