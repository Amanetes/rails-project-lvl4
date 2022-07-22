# frozen_string_literal: true

module Web
  module Repositories
    class ApplicationController < ApplicationController
      before_action :authenticate_user!

      def resource_repository
        @resource_repository ||= Repository.find(params[:repository_id])
      end
    end
  end
end
