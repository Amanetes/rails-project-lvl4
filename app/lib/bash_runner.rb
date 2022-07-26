# frozen_string_literal: true

class BashRunner
  class << self
    def run(cmd)
      Open3.popen3(cmd) do |_stdin, stdout, _stderr, _wait_thr|
        stdout.read
      end
    end
  end
end
