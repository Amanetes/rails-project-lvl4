class RepositoryLoaderJob < ApplicationJob
  queue_as :default

  def perform(repository)
    Repository.find_or_initialize_by(id: github_id)
  end
end
