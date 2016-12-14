module Secured
  extend ActiveSupport::Concern
  include ApplicationHelper

  included do
    before_action :logged_in_using_omniauth?
  end

  def logged_in_using_omniauth?
    redirect_to getAuthUrl() unless session[:userinfo].present?
  end
end
