require 'stringio'
require 'rsvg2'

module SvgPdfReporter
  class Base < AbstractController::Base
    include AbstractController::Rendering
    include ActionView::Layouts

    prepend_view_path('app/views')

    def report(action)
      source = generate_svg(action)
      render_pdf(source)
    end

    def generate_svg(action)
      render_to_string layout: 'reporter', action: action, formats: :svg
    end

    private

    def render_pdf(source)
      sink = StringIO.new

      handle = RSVG::Handle.new_from_data(source)
      dim = handle.dimensions
      Cairo::PDFSurface.new(sink, dim.width, dim.height) do |surface|
        cairo = Cairo::Context.new(surface)
        cairo.render_rsvg_handle(handle)
        cairo.show_page
      end
      handle.close

      sink.string
    end

    def _prefixes
      self.class.to_s.underscore.gsub(/_reporter/i, '')
    end
  end
end
