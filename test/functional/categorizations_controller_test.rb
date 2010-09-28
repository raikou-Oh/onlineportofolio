require 'test_helper'

class CategorizationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categorizations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create categorization" do
    assert_difference('Categorization.count') do
      post :create, :categorization => { }
    end

    assert_redirected_to categorization_path(assigns(:categorization))
  end

  test "should show categorization" do
    get :show, :id => categorizations(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => categorizations(:one).to_param
    assert_response :success
  end

  test "should update categorization" do
    put :update, :id => categorizations(:one).to_param, :categorization => { }
    assert_redirected_to categorization_path(assigns(:categorization))
  end

  test "should destroy categorization" do
    assert_difference('Categorization.count', -1) do
      delete :destroy, :id => categorizations(:one).to_param
    end

    assert_redirected_to categorizations_path
  end
end
