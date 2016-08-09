# frozen_string_literal: true
require 'test_helper'

class UnauthorizedControllerTest < ActionController::TestCase
  test 'should get show' do
    get :show
    assert_response :success
  end
end
