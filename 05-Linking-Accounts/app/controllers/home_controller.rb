# frozen_string_literal: true
class HomeController < ApplicationController
  def show
    @user = session[:userinfo]
  end
end
