class SecuredController < ApplicationController
  before_action :logged_in?

  private

  def logged_in?
    unless session[:token_id].present?
      redirect_to '/'
    end
  end
end
