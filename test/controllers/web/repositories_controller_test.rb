# frozen_string_literal: true

require 'test_helper'

module Web
  class RepositoriesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:one)
      sign_in @user
      @repository = repositories(:one)
    end

    test 'should GET repositories#index' do
      get repositories_url
      assert_response :success
    end

    test 'should GET repositories#show' do
      get repository_url(@repository)
      assert_response :success
    end

    test 'should GET repositories#new' do
      get new_repository_path
      assert_response :success
    end
  end
end
