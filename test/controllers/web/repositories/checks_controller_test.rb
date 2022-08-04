# frozen_string_literal: true

require 'test_helper'

module Web
  module Repositories
    class ChecksControllerTest < ActionDispatch::IntegrationTest
      include ActiveJob::TestHelper

      setup do
        @user = users(:one)
        sign_in @user
        @repository = repositories(:one)
        @check = repository_checks(:javascript)
      end

      test 'should show repository check' do
        get repository_check_url(@repository, @check)
        assert_response :success
      end

      test 'should create repository check' do
        post repository_checks_url(@repository)
        assert_response :redirect
        assert { @repository.checks.last.passed? == true }
      end
    end
  end
end
