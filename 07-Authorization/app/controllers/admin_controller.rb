# frozen_string_literal: true
class AdminController < ApplicationController
  include Secured
  before_action :isAdmin?

  def show
  end

  private

  def isAdmin?
    redirect_to unauthorized_show_path unless roles.include?('admin')
  end

  def roles
    app_metadata ? app_metadata[:roles] : []
  end

  def app_metadata
    session[:userinfo][:extra][:raw_info][:app_metadata]
  end
end
