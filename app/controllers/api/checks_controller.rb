# frozen_string_literal: true

module Api
  class ChecksController < Api::ApplicationController

    def create
      @repository = Repository.find_by(github_id: params[:repository][:id])

      return head :not_found if repository.blank?
    end
  end
end
