require 'test_helper'

class PersonPetConsiderationsControllerTest < ActionController::TestCase
  setup do
    @person_pet_consideration = person_pet_considerations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:person_pet_considerations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create person_pet_consideration" do
    assert_difference('PersonPetConsideration.count') do
      post :create, person_pet_consideration: { considering_id: @person_pet_consideration.considering_id, pet_id: @person_pet_consideration.pet_id }
    end

    assert_redirected_to person_pet_consideration_path(assigns(:person_pet_consideration))
  end

  test "should show person_pet_consideration" do
    get :show, id: @person_pet_consideration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @person_pet_consideration
    assert_response :success
  end

  test "should update person_pet_consideration" do
    patch :update, id: @person_pet_consideration, person_pet_consideration: { considering_id: @person_pet_consideration.considering_id, pet_id: @person_pet_consideration.pet_id }
    assert_redirected_to person_pet_consideration_path(assigns(:person_pet_consideration))
  end

  test "should destroy person_pet_consideration" do
    assert_difference('PersonPetConsideration.count', -1) do
      delete :destroy, id: @person_pet_consideration
    end

    assert_redirected_to person_pet_considerations_path
  end
end
