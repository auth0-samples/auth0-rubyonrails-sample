class SecuredController < ApplicationController
  before_action :logged_in_using_omniauth?

  private

  def logged_in_using_omniauth?
    redirect_to '/' unless session[:userinfo].present?
  end
end
