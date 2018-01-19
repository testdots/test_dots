module TestDots
  module CIAdapters
    class TravisCI < TestDots::CIAdapters::Base
      def active?
        ENV.has_key?('TRAVIS')
      end

      def branch
        ENV['TRAVIS_BRANCH']
      end

      def build
        ENV['TRAVIS_BUILD_NUMBER']
      end
    end
  end
end
