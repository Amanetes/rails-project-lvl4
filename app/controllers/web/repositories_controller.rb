# frozen_string_literal: true

module Web
  class RepositoriesController < ApplicationController
    before_action :authenticate_user!

    def index
      @repositories = current_user.repositories
    end

    def show; end

    def new
      @repository = current_user.repositories.build
      @remote_repositories = Repository.fetch_repositories(current_user.token)
    end

    def create
      @repository = current_user.repositories.build(repository_params)
      if @repository.save
        # TODO: Repository update job
        flash[:success] = 'Репозиторий подготовлен'
        redirect_to repositories_url
      else
        flash.now[:error] = 'Не удалось создать репозиторий'
        render :new, status: :unprocessable_entity
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
