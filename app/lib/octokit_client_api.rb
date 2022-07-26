# frozen_string_literal: true

class OctokitClientApi
  attr_accessor :client

  include Rails.application.routes.url_helpers
  def initialize(token)
    @client = Octokit::Client.new access_token: token, per_page: 100
  end

  def repositories
    @client.repos
  end

  def commits(github_id)
    @client.list_commits(github_id)
  end

  def repository(github_id)
    @client.repo(github_id)
  end

  def create_webhook(github_id)
    @client.create_hook(
      github_id,
      'web',
      {
        url: api_checks_url,
        content_type: 'json'
      },
      {
        events: ['push'],
        active: true
      }
    )
  end
end
