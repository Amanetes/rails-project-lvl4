# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :octokit_client_api, -> { OctokitClientApiStub }
  else
    register :octokit_client_api, -> { OctokitClientApi }
  end
end
