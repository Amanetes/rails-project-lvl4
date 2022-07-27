# frozen_string_literal: true

class BashRunner
  class << self
    def run(cmd)
      stdout, stderr, exit_status = Open3.popen3(cmd) do |_stdin, stdout, stderr, wait_thr|
        [stdout.read, stderr.read, wait_thr.value]
      end
      [stdout, stderr, exit_status.exitstatus]
    end
  end
end
