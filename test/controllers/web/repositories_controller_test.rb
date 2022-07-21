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

    test 'should POST repositories#create' do
      assert_difference 'Repository.count', 1 do
        post repositories_url, params: { repository:
                                         { github_id: 1234 } }
      end
      repository = Repository.find_by! github_id: 1234
      assert { repository }
      assert_redirected_to repositories_url
    end
  end
end
