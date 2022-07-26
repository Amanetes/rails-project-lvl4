# frozen_string_literal: true

class Repository
  class CheckService
    class << self
      def run_check(check)
        repository = check.repository
        client = ApplicationContainer[:octokit_client_api].new(repository.user.token)
        repository_check_manager = ApplicationContainer[:repository_check_manager]
        check.check!
        check_results = repository_check_manager.check(repository)
        last_commit = client.commits(repository.github_id).first

        check.update(
          passed: check_results[:issues_count].zero?,
          issues_count: check_results[:issues_count],
          result: check_results[:issues] || [],
          reference_url: last_commit[:html_url],
          reference_sha: last_commit[:sha][0, 7]
        )
        check.finish!
      end
    end
  end
end
