# frozen_string_literal: true

class OctokitClientApiStub
  def initialize(token)
    @token = token
  end

  def repositories
    repo_stub = get_fixture_path('repositories.json')
    repo_stub_content = File.read(repo_stub)
    JSON.parse(repo_stub_content).map(&:symbolize_keys)
  end

  def commits(_github_id)
    commits_path = get_fixture_path('commits.json')
    commits_stub_content = File.read(commits_path)
    JSON.parse(commits_stub_content).map(&:symbolize_keys)
  end

  private

  def get_fixture_path(filename)
    Rails.root.join('test/fixtures/files', filename)
  end
end
