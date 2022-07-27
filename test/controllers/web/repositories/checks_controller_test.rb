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

      test 'should GET web/repositories/checks#show' do
        get repository_check_url(@repository, @check)
        assert_response :success
      end

      test 'should GET web/repositories/checks#create' do
        post repository_checks_url(@repository)

        assert_response :redirect
        assert_enqueued_with(job: RepositoryCheckJob)
        assert { @repository.checks.last.passed? == false }
      end
    end
  end
end
