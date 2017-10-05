Rails.application.config.middleware.use OmniAuth::Builder do
  if ENV['AUTH0_AUDIENCE'].blank?
    audience = URI::HTTPS.build(host: ENV['AUTH0_DOMAIN'], path: '/userinfo').to_s
  else
    audience = ENV['AUTH0_AUDIENCE']
  end

  provider(
    :auth0,
    ENV['AUTH0_CLIENT_ID'],
    ENV['AUTH0_CLIENT_SECRET'],
    ENV['AUTH0_DOMAIN'],
    callback_path: '/auth/auth0/callback',
    authorize_params: {
        scope: 'openid profile',
        audience: audience
    }
  )
end
