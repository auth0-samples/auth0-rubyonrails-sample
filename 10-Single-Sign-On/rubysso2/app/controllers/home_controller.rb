class HomeController < ApplicationController
  def show
    # If logged in, redirect to /dashboard
    if session[:userinfo].present? then
      redirect_to '/dashboard'
    end
  end
end
