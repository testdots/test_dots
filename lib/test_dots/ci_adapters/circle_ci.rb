module TestDots
  module CIAdapters
    class CircleCI < TestDots::CIAdapters::Base
      def active?
        ENV.has_key?('CIRCLECI')
      end

      def branch
        ENV['CIRCLE_BRANCH']
      end

      def build
        ENV['CIRCLE_BUILD_NUM']
      end

      def url
        ENV['CIRCLE_BUILD_URL']
      end
    end
  end
end
