# frozen_string_literal: true

class GithubApiStub
  def initialize(_token);end

  def repositories
    repo_stub = get_fixture('repositories.json')
    JSON.parse(File.read(repo_stub)).map(&:symbolize_keys)
  end

  private

  def get_fixture(filename)
    Rails.root.join('test/fixtures/files', filename)
  end
end
