module TestDots
  module CIAdapters
    class Base
      def active?
        true
      end

      def branch
        '(unknown)'
      end

      def build
        nil
      end

      def url
        nil
      end
    end
  end
end
