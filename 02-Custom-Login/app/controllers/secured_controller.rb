# frozen_string_literal: true
class SecuredController < ApplicationController
  before_action :logged_in?

  private

  def logged_in?
    redirect_to '/' unless session[:token_id].present?
  end
end
