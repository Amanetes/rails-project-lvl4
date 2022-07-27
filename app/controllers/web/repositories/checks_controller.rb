# frozen_string_literal: true

module Web
  module Repositories
    class ChecksController < ApplicationController
      before_action :set_check, only: %i[show]
      before_action :resource_repository, only: %i[show create]

      def show; end

      def create
        @check = @resource_repository.checks.build
        if @check.save
          flash[:notice] = t('.create')
          RepositoryCheckJob.perform_later(@check)
          redirect_to @resource_repository
        else
          flash.now[:error] = t('.error')
          render 'web/repositories/checks/show'
        end
      end

      private

      def set_check
        @check = Repository::Check.find(params[:id])
      end
    end
  end
end
