require 'test_helper'

class LineEatsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_eats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_eat" do
    assert_difference('LineEat.count') do
      post :create, :line_eat => { }
    end

    assert_redirected_to line_eat_path(assigns(:line_eat))
  end

  test "should show line_eat" do
    get :show, :id => line_eats(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => line_eats(:one).to_param
    assert_response :success
  end

  test "should update line_eat" do
    put :update, :id => line_eats(:one).to_param, :line_eat => { }
    assert_redirected_to line_eat_path(assigns(:line_eat))
  end

  test "should destroy line_eat" do
    assert_difference('LineEat.count', -1) do
      delete :destroy, :id => line_eats(:one).to_param
    end

    assert_redirected_to line_eats_path
  end
end
