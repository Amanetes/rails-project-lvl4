# frozen_string_literal: true

module Web
  class RepositoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_repository, only: %i[show]

    def index
      @repositories = current_user.repositories
    end

    def show; end

    def new
      @repository = current_user.repositories.build
      client = ApplicationContainer[:octokit_client_api].new(current_user.token)
      @remote_repositories = client.repositories
                                   .select do |repo|
        Repository.language.values.include?(repo[:language]&.downcase) &&
          current_user.repositories.map(&:name).exclude?(repo[:name])
      end
    end

    def create
      @repository = current_user.repositories.build(repository_params)
      if @repository.save
        RepositoryUpdateJob.perform_later(@repository)
        CreateWebhookJob.perform_later(@repository)
        flash[:success] = t('.create')
        redirect_to repositories_url
      else
        flash[:notice] = t('.exists')
        redirect_to repositories_url, status: :see_other
      end
    end

    private

    def set_repository
      @repository = Repository.find(params[:id])
    end

    def repository_params
      params.require(:repository).permit(:github_id)
    end
  end
end
