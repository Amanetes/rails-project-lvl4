# frozen_string_literal: true

require 'test_helper'

module Api
  class ChecksControllerTest < ActionDispatch::IntegrationTest
    test 'should GET api/checks#create' do
      repository = repositories(:one)
      post api_checks_url, params: { repository: { full_name: repository.full_name } }

      assert_response :success
      assert_enqueued_with(job: RepositoryCheckJob)
      assert { repository.checks.present? }
      assert { repository.checks.last.passed? == false }
    end
  end
end
