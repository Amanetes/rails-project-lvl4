# frozen_string_literal: true

# TODO: Класс прогоняет репозитории линтерами, а сам вывозов класса в Джобе
class RepositoryCheckManager
  class << self
    def check(repository)
      RepositoryLoader.clone(repository)
      repository_path = get_repository_path(repository)
      linter = {
        javascript: ->(path) { BashRunner.run("yarn run eslint #{path} --config .eslintrc.yml --format json --no-eslintrc") },
        ruby: ->(path) { BashRunner.run("bundle exec rubocop #{path} --format-json -c .rubocop.yml") }
      }
      check_result = JSON.parse(linter[repository.language.to_sym].call(repository_path))
      RepositoryLoader.remove(repository)
      JSON.pretty_generate(check_result)
    end

    private

    def get_repository_path(repository)
      Rails.root.join('tmp', 'repositories', repository.full_name)
    end
  end
end
