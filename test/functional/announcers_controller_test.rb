require 'test_helper'

class AnnouncersControllerTest < ActionController::TestCase
  setup do
    @announcer = announcers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:announcers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create announcer" do
    assert_difference('Announcer.count') do
      post :create, :announcer => @announcer.attributes
    end

    assert_redirected_to announcer_path(assigns(:announcer))
  end

  test "should show announcer" do
    get :show, :id => @announcer.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @announcer.to_param
    assert_response :success
  end

  test "should update announcer" do
    put :update, :id => @announcer.to_param, :announcer => @announcer.attributes
    assert_redirected_to announcer_path(assigns(:announcer))
  end

  test "should destroy announcer" do
    assert_difference('Announcer.count', -1) do
      delete :destroy, :id => @announcer.to_param
    end

    assert_redirected_to announcers_path
  end
end
