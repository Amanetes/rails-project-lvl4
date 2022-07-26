# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :octokit_client_api, -> { OctokitClientApiStub }
    register :repository_check_manager, -> { RepositoryCheckManagerStub }
  else
    register :octokit_client_api, -> { OctokitClientApi }
    register :repository_check_manager, -> { RepositoryCheckManager }
  end
end
