module SvgPdfReporter
  module Helpers
    extend ActiveSupport::Autoload

    autoload :ViewHelper

    ActiveSupport.on_load :action_view do
      include SvgPdfReporter::Helpers::ViewHelper
    end
  end
end
