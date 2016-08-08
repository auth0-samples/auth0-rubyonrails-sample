# frozen_string_literal: true
class DashboardController < ApplicationController
  include Secured
  include ClientHelper
  def show
    @user = ClientHelper.client_user(session[:userinfo]).user_info
  end
end
