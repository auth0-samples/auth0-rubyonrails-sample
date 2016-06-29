class Auth0Controller < ApplicationController
  def callback
    redirect_to '/dashboard'
  end

  def failure
    @error_msg = request.params['message']
  end
end
