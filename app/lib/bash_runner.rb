# frozen_string_literal: true

class BashRunner
  class << self
    def run(cmd)
      _stdin, stdout, _stderr, _wait_thr = Open3.popen3(cmd)
      stdout.read
    end
  end
end
