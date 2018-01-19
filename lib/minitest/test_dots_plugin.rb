require 'test_dots'
require 'pathname'

module Minitest
  def self.plugin_test_dots_init(_)
    if TestDots.configuration.collect_test_data?
      self.reporter << TestDotsReporter.new
    end
  end

  class TestDotsReporter < AbstractReporter
    def initialize
      @dir = Pathname.new(Dir.pwd)
      @results = []
      @start_time = nil
    end

    def start
      @start_time = Minitest.clock_time
    end

    def record(result)
      status = if result.passed?
        'passed'
      elsif result.skipped?
        'skipped'
      else
        'failed'
      end

      @results << {
        description: result.name,
        full_description: "#{result.class}##{result.name}",
        location: location_for_result(result),
        run_time: result.time,
        status: status
      }
    end

    def report
      run_time = Minitest.clock_time - @start_time

      TestDots.send_report(
        framework: 'minitest',
        run_time: run_time,
        results: @results
      )
    end

    private

    def location_for_result(result)
      file, line = result.method(result.name).source_location
      if file
        [relative_path(file).to_s, line].join(':')
      else
        nil
      end
    end

    def relative_path(test_path)
      expaned_test_path = File.expand_path(test_path, @dir)
      Pathname.new(expaned_test_path).relative_path_from(@dir)
    end
  end
end
