# frozen_string_literal: true

class OctokitClientApiStub
  def initialize(token)
    @token = token
  end

  def repositories
    repo_stub = get_fixture('repositories.json')
    repo_stub_content = File.read(repo_stub)
    JSON.parse(repo_stub_content).map(&:symbolize_keys)
  end

  private

  def get_fixture(filename)
    Rails.root.join('test/fixtures/files', filename)
  end
end
