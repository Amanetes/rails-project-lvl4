# frozen_string_literal: true

module Api
  class ChecksController < Api::ApplicationController
    skip_before_action :verify_authenticity_token, only: :create

    def create
      @repository = Repository.find_by(full_name: params[:repository][:full_name])

      return head :not_found if repository.nil?

      @check = repository.checks.build
      RepositoryCheckJob.perform_later(check) if @check.save
      head :ok
    end
  end
end
