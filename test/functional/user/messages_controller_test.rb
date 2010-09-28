require 'test_helper'

class User::MessagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create message" do
    assert_difference('User::Message.count') do
      post :create, :message => { }
    end

    assert_redirected_to message_path(assigns(:message))
  end

  test "should show message" do
    get :show, :id => user_messages(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => user_messages(:one).to_param
    assert_response :success
  end

  test "should update message" do
    put :update, :id => user_messages(:one).to_param, :message => { }
    assert_redirected_to message_path(assigns(:message))
  end

  test "should destroy message" do
    assert_difference('User::Message.count', -1) do
      delete :destroy, :id => user_messages(:one).to_param
    end

    assert_redirected_to user_messages_path
  end
end
