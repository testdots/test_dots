module TestDots
  module CIAdapters
    class Jenkins < TestDots::CIAdapters::Base
      def active?
        ENV.has_key?('JENKINS_URL')
      end

      def branch
        ENV['GIT_BRANCH']
      end

      def build
        ENV['BUILD_NUMBER']
      end

      def url
        ENV['BUILD_URL']
      end
    end
  end
end
