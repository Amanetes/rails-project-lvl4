# frozen_string_literal: true

class RepositoryCheckManager
  extend RepositoryLoader
  class << self
    def check(repository)
      clone(repository)
      repository_path = get_repository_path(repository)
      linter = {
        javascript: ->(path) { run_eslint_check(path) },
        ruby: ->(path) { run_rubocop_check(path) }
      }
      check_result = linter[repository.language.to_sym].call(repository_path)
      remove(repository)
      check_result
    end

    def run_eslint_check(path)
      cmd = "node_modules/eslint/bin/eslint.js #{path} --config .eslintrc.yml --format json --no-eslintrc"
      output = BashRunner.run(cmd)
      parsed_result = JSON.parse(output.presence || '[]')
      offense_output = parsed_result.select { |issue| issue['errorCount'].positive? }
                                    .each_with_object([]) do |issue, acc|
        acc << {
          file_path: issue['filePath'],
          messages: issue['messages'].map do |msg|
            {
              rule_id: msg['ruleId'],
              message: msg['message'],
              line: msg['line'],
              column: msg['column']
            }
          end
        }
      end
      { issues: offense_output, issues_count: parsed_result.reduce(0) { |acc, issue| acc + issue['errorCount'] } }
    end

    def run_rubocop_check(path)
      cmd = "bundle exec rubocop #{path} --format json -c .rubocop.yml"
      output = BashRunner.run(cmd)
      parsed_result = JSON.parse(output.presence || '[]')
      offense_output = parsed_result['files'].select { |issue| issue['offenses'].present? }
                                             .each_with_object([]) do |issue, acc|
        acc << {
          file_path: issue['path'],
          messages: issue['offenses'].map do |msg|
            {
              rule_id: msg['cop_name'],
              message: msg['message'],
              line: msg['location']['start_line'],
              column: msg['location']['start_column']
            }
          end
        }
      end
      { issues: offense_output, issues_count: parsed_result['summary']['offense_count'] }
    end
  end
end
