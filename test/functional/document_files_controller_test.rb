require 'test_helper'

class DocumentFilesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:document_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create document_file" do
    assert_difference('DocumentFile.count') do
      post :create, :document_file => { }
    end

    assert_redirected_to document_file_path(assigns(:document_file))
  end

  test "should show document_file" do
    get :show, :id => document_files(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => document_files(:one).to_param
    assert_response :success
  end

  test "should update document_file" do
    put :update, :id => document_files(:one).to_param, :document_file => { }
    assert_redirected_to document_file_path(assigns(:document_file))
  end

  test "should destroy document_file" do
    assert_difference('DocumentFile.count', -1) do
      delete :destroy, :id => document_files(:one).to_param
    end

    assert_redirected_to document_files_path
  end
end
