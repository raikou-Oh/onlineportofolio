require 'test_helper'

class Admin::ToolsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_tools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tool" do
    assert_difference('Admin::Tool.count') do
      post :create, :tool => { }
    end

    assert_redirected_to tool_path(assigns(:tool))
  end

  test "should show tool" do
    get :show, :id => admin_tools(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => admin_tools(:one).to_param
    assert_response :success
  end

  test "should update tool" do
    put :update, :id => admin_tools(:one).to_param, :tool => { }
    assert_redirected_to tool_path(assigns(:tool))
  end

  test "should destroy tool" do
    assert_difference('Admin::Tool.count', -1) do
      delete :destroy, :id => admin_tools(:one).to_param
    end

    assert_redirected_to admin_tools_path
  end
end
