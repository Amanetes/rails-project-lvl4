# frozen_string_literal: true

class OctokitClientApi
  attr_accessor :client

  def initialize(token)
    @client = Octokit::Client.new access_token: token, auto_paginate: true
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
end
