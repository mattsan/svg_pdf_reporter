module SvgPdfReporter
  module Helpers
    module ViewHelper
      def line(options)
        content_tag(:line, nil, options)
      end

      def rect(options)
        content_tag(:rect, nil, options)
      end
    end
  end
end
