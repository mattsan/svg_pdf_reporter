require 'stringio'
require 'rsvg2'

module SvgPdfReporter
  class Base < AbstractController::Base
    abstract!

    include AbstractController::Rendering
    include ActionView::Layouts

    prepend_view_path('app/views')

    class << self
      private :new

      def dpi=(val)
        @@dpi = val
      end

      def dpi
        @@dpi ||= 72
      end

      def as_pdf(action)
        new.as_pdf(action)
      end

      def as_svg(action)
        new.as_svg(action)
      end
    end

    def as_pdf(action)
      send(action)
      source = as_svg(action)
      render_pdf(source)
    end

    def as_svg(action)
      send(action)
      render_to_string layout: 'reporter', action: action, formats: :svg
    end

    protected

    def self.method_missing(method_name)
      if action_methods.include?(method_name.to_s)
        Report.new(self, method_name)
      else
        super
      end
    end

    private

    def render_pdf(source)
      sink = StringIO.new

      handle = RSVG::Handle.new_from_data(source)
      handle.dpi = Base.dpi
      dim = handle.dimensions
      Cairo::PDFSurface.new(sink, dim.width, dim.height) do |surface|
        context = Cairo::Context.new(surface)
        context.render_rsvg_handle(handle)
        context.show_page
      end
      handle.close

      sink.string
    end
  end
end
