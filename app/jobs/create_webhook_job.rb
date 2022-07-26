# frozen_string_literal: true

class CreateWebhookJob < ApplicationJob
  queue_as :default

  def perform(repository)
    client = ApplicationContainer[:octokit_client_api].new(repository.user.token)
    client.create_webhook(repository.github_id)
  end
end
