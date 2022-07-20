# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :github_api_stub, -> { GithubApiStub }
  else
    register :github_api, -> { GithubApi }
  end
end
