require 'test_helper'

class ConsideringsControllerTest < ActionController::TestCase
  setup do
    @considering = considerings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:considerings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create considering" do
    assert_difference('Considering.count') do
      post :create, considering: {  }
    end

    assert_redirected_to considering_path(assigns(:considering))
  end

  test "should show considering" do
    get :show, id: @considering
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @considering
    assert_response :success
  end

  test "should update considering" do
    patch :update, id: @considering, considering: {  }
    assert_redirected_to considering_path(assigns(:considering))
  end

  test "should destroy considering" do
    assert_difference('Considering.count', -1) do
      delete :destroy, id: @considering
    end

    assert_redirected_to considerings_path
  end
end
