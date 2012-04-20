require 'test_helper'

class MicrogroupsControllerTest < ActionController::TestCase
  setup do
    @microgroup = microgroups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:microgroups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create microgroup" do
    assert_difference('Microgroup.count') do
      post :create, microgroup: @microgroup.attributes
    end

    assert_redirected_to microgroup_path(assigns(:microgroup))
  end

  test "should show microgroup" do
    get :show, id: @microgroup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @microgroup
    assert_response :success
  end

  test "should update microgroup" do
    put :update, id: @microgroup, microgroup: @microgroup.attributes
    assert_redirected_to microgroup_path(assigns(:microgroup))
  end

  test "should destroy microgroup" do
    assert_difference('Microgroup.count', -1) do
      delete :destroy, id: @microgroup
    end

    assert_redirected_to microgroups_path
  end
end
