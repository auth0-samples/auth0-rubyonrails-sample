Rails.application.config.auth0 = Rails.application.config_for(:auth0)

Rails.application.config.middleware.use OmniAuth::Builder do
  auth0_config = Rails.application.config_for(:auth0)
  provider(
    :auth0,
    Rails.application.config.auth0['auth0_client_id'],
    Rails.application.config.auth0['auth0_client_secret'],
    Rails.application.config.auth0['auth0_domain'],
    callback_path: '/auth/auth0/callback',
    authorize_params: {
      scope: 'openid profile email'
    }
  )
end
