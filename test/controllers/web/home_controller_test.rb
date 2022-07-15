# frozen_string_literal: true

require 'test_helper'
module Web
  class HomeControllerTest < ActionDispatch::IntegrationTest
    test 'should GET home#index' do
      get root_path
      assert_response :success
    end
  end
end
