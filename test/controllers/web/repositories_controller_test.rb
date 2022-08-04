# frozen_string_literal: true

require 'test_helper'

module Web
  class RepositoriesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:one)
      sign_in @user
      @repository = repositories(:one)
    end

    test 'should GET index' do
      get repositories_url
      assert_response :success
    end

    test 'should show repository' do
      get repository_url(@repository)
      assert_response :success
    end

    test 'should get new' do
      get new_repository_url
      assert_response :success
    end

    test 'should create repository' do
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
