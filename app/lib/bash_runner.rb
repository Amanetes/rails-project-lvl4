# frozen_string_literal: true

class BashRunner
  class << self
    def run(cmd)
      output = Open3.popen3(cmd) do |_stdin, stdout, _stderr, _wait_thr|
        stdout.read
      end
      JSON.parse(output.presence || '{}')
    end
  end
end
