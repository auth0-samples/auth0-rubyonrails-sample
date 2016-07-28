class AdminController < SecuredController
  before_action :isAdmin?

  def show
  end

  private

  def isAdmin?
    unless roles.include?('admin')
      redirect_to unauthorized_show_path
    end
  end

  def roles
    session[:userinfo][:extra][:raw_info][:app_metadata][:roles] || []
  end

end
