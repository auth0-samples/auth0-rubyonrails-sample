# frozen_string_literal: true
class LogoutController < ApplicationController
  include LogoutHelper
  def logout
    redirect_to logout_url.to_s
  end
end
