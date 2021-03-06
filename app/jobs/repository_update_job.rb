# frozen_string_literal: true

class RepositoryUpdateJob < ApplicationJob
  queue_as :default

  def perform(repository)
    Repository::UpdateService.update(repository)
  end
end
