# frozen_string_literal: true

class BashRunner
  class << self
    def run(cmd)
      Open3.popen3(cmd) do |_stdin, stdout, stderr, wait_thr|
        exit_status = wait_thr.value
        raise StandardError, stderr unless exit_status.success?

        stdout.read
      end
    end
  end
end
