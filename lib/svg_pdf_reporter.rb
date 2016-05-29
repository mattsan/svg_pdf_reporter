module SvgPdfReporter
  class Base
    include AbstractController::Rendering
    include ActionView::Layouts

    prepend_view_path('app/views')

    def report(action)
      to_svg(action)
    end

    def to_svg(action)
      render_to_string layout: 'reporter', action: action, formats: :svg
    end

    private

    def _prefixes
      self.class.to_s.underscore.gsub(/_reporter/i, '')
    end
  end
end
