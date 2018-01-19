module TestDots
  class RSpecListener
    def self.register
      RSpec.configure do |config|
        methods = [
          :dump_summary,
          :example_passed,
          :example_pending,
          :example_failed,
          :close
        ]
        config.reporter.register_listener self.new, *methods
      end
    end

    def initialize
      @results = []
      @dir = Pathname.new(Dir.pwd)
    end

    def close(_)
      attributes = TestDots.send_report(
        framework: 'rspec',
        load_time: @load_time,
        run_time: @run_time,
        results: @results
      )
    end

    def dump_summary(summary_notification)
      @load_time = summary_notification.load_time
      @run_time = summary_notification.duration
    end

    def example_pending(notification)
      example_finished(notification)
    end

    def example_passed(notification)
      example_finished(notification)
    end

    def example_failed(notification)
      example_finished(notification)
    end

    private

    def example_finished(example_notification)
      example = example_notification.example
      execution_result = example.execution_result

      @results << {
        description: example.description,
        full_description: example.full_description,
        location: relative_path(example.location),
        run_time: execution_result.run_time,
        status: execution_result.status
      }
      nil
    end

    def relative_path(test_path)
      expaned_test_path = File.expand_path(test_path, @dir)
      Pathname.new(expaned_test_path).relative_path_from(@dir).to_s
    end
  end
end
