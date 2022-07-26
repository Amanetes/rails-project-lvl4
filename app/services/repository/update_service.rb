# frozen_string_literal: true

class Repository
  class UpdateService
    class << self
      def update(repository)
        client = ApplicationContainer[:octokit_client_api].new(repository.user.token)
        remote_repo = client.repository(repository.github_id)
        attributes = build_attributes(remote_repo)
        repository.update!(attributes)
        repository.save!
      rescue Octokit::NotFound => e
        Rails.logger.debug(e.full_message)
      end

      def build_attributes(remote_repo)
        {
          name: remote_repo[:name],
          language: remote_repo[:language]&.downcase,
          full_name: remote_repo[:full_name],
          clone_url: remote_repo[:clone_url]
        }
      end
    end
  end
end
