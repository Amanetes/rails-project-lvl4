# frozen_string_literal: true

class RepositoryCheckManager
  class << self
    def check(repository)
      mapping = {
        javascript: -> { BashRunner.run('yarn run eslint --no-eslintrc --format json') },
        ruby: -> { BashRunner.run('bundle exec rubocop --format=json --config ./.rubocop.yml') }
      }
      check_result = JSON.parse(mapping[repository.language.to_sym].call)
      JSON.pretty_generate(check_result)
    end
  end
end
