# frozen_string_literal: true

class RepositoryUpdateJob < ApplicationJob
  queue_as :default

  def perform(repository)
    Repository::UpdateService.update(repository)
  rescue Octokit::NotFound => e
    Rails.logger.debug(e.full_message)
  end
end
