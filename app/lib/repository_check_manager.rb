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
      cmd = "npx eslint #{path} --config .eslintrc.yml --format json --no-eslintrc"
      output = BashRunner.run(cmd)
      parsed_result = JSON.parse(output, symbolize_names: true)
      offense_output = parsed_result.select { |issue| issue[:errorCount].positive? }
                                    .flat_map do |issue|
        issue[:messages].each_with_object([]) do |msg, acc|
          acc << {
            file_path: issue[:filePath],
            rule_id: msg[:ruleId],
            message: msg[:message],
            line: msg[:line],
            column: msg[:column]
          }
        end
      end
      { issues: offense_output, issues_count: parsed_result.reduce(0) { |acc, issue| acc + issue[:errorCount] } }
    end

    def run_rubocop_check(path)
      cmd = "rubocop #{path} --format json -c .rubocop.yml"
      output = BashRunner.run(cmd)
      parsed_result = JSON.parse(output, symbolize_names: true)
      offense_output = parsed_result[:files]
                       .select { |issue| issue[:offenses].present? }
                       .flat_map do |issue|
        issue[:offenses].each_with_object([]) do |offense, acc|
          acc << {
            file_path: issue[:path],
            rule_id: offense[:cop_name],
            message: offense[:message],
            line: offense[:location][:start_line],
            column: offense[:location][:start_column]
          }
        end
      end
      { issues: offense_output, issues_count: parsed_result[:summary][:offense_count] }
    end
    end
end
