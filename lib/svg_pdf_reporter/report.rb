module SvgPdfReporter
  class Report
    def initialize(reporter_class, action)
      @reporter_class, @action = reporter_class, action
    end

    def as_pdf
      @reporter_class.as_pdf(@action)
    end

    def as_svg
      @reporter_class.as_svg(@action)
    end

    def save_pdf_to_file(filename)
      File.new(filename, 'wb').write(as_pdf)
    end
  end
end
