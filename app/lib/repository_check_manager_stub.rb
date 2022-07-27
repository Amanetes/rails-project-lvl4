# frozen_string_literal: true

class RepositoryCheckManagerStub
  class << self
    def check(_repository)
      { issues: [''], issues_count: 0 }
    end

    def run_eslint_check(_path)
      { issues: [''], issues_count: 0 }
    end

    def run_rubocop_check(_path)
      { issues: [''], issues_count: 0 }
    end
  end
end
