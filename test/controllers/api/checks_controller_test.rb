# frozen_string_literal: true

require 'test_helper'

module Api
  class ChecksControllerTest < ActionDispatch::IntegrationTest
    test 'should create check' do
      repository = repositories(:two)
      post api_checks_url, params: { repository: { full_name: repository.full_name } }

      assert_response :success
      assert { repository.checks.present? }
      assert { repository.checks.last.passed? == true }
    end
  end
end
