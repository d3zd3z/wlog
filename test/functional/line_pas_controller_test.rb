require 'test_helper'

class LinePasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_pas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_pa" do
    assert_difference('LinePa.count') do
      post :create, :line_pa => { }
    end

    assert_redirected_to line_pa_path(assigns(:line_pa))
  end

  test "should show line_pa" do
    get :show, :id => line_pas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => line_pas(:one).to_param
    assert_response :success
  end

  test "should update line_pa" do
    put :update, :id => line_pas(:one).to_param, :line_pa => { }
    assert_redirected_to line_pa_path(assigns(:line_pa))
  end

  test "should destroy line_pa" do
    assert_difference('LinePa.count', -1) do
      delete :destroy, :id => line_pas(:one).to_param
    end

    assert_redirected_to line_pas_path
  end
end
