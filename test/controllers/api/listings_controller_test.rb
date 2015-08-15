require 'test_helper'

class Api::ListingsControllerTest < ActionController::TestCase
  setup do
    @api_listing = api_listings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_listings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_listing" do
    assert_difference('Api::Listing.count') do
      post :create, api_listing: {  }
    end

    assert_redirected_to api_listing_path(assigns(:api_listing))
  end

  test "should show api_listing" do
    get :show, id: @api_listing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_listing
    assert_response :success
  end

  test "should update api_listing" do
    patch :update, id: @api_listing, api_listing: {  }
    assert_redirected_to api_listing_path(assigns(:api_listing))
  end

  test "should destroy api_listing" do
    assert_difference('Api::Listing.count', -1) do
      delete :destroy, id: @api_listing
    end

    assert_redirected_to api_listings_path
  end
end
