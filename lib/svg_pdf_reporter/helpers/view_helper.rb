class Fixnum
  INCH = 25.4

  def mm
    self / INCH * SvgPdfReporter::Base.dpi
  end

  def cm
    self.mm * 10
  end

  def inch
    self * SvgPdfReporter::Base.dpi
  end
end

module SvgPdfReporter
  module Helpers
    module ViewHelper
      PaperSize = Struct.new(:width, :height)

      PaperSizes = {
        A0:  -> { PaperSize.new( 841.mm, 1189.mm).freeze },
        A1:  -> { PaperSize.new( 594.mm,  841.mm).freeze },
        A2:  -> { PaperSize.new( 420.mm,  594.mm).freeze },
        A3:  -> { PaperSize.new( 297.mm,  420.mm).freeze },
        A4:  -> { PaperSize.new( 210.mm,  297.mm).freeze },
        A5:  -> { PaperSize.new( 148.mm,  210.mm).freeze },
        A6:  -> { PaperSize.new( 105.mm,  148.mm).freeze },
        A7:  -> { PaperSize.new(  74.mm,  105.mm).freeze },
        A8:  -> { PaperSize.new(  52.mm,   74.mm).freeze },
        A9:  -> { PaperSize.new(  37.mm,   52.mm).freeze },
        A10: -> { PaperSize.new(  26.mm,   37.mm).freeze },
        A11: -> { PaperSize.new(  18.mm,   26.mm).freeze },
        A12: -> { PaperSize.new(  13.mm,   18.mm).freeze },

        B0:  -> { PaperSize.new(1030.mm, 1456.mm).freeze },
        B1:  -> { PaperSize.new( 728.mm, 1030.mm).freeze },
        B2:  -> { PaperSize.new( 515.mm,  728.mm).freeze },
        B3:  -> { PaperSize.new( 364.mm,  515.mm).freeze },
        B4:  -> { PaperSize.new( 257.mm,  364.mm).freeze },
        B5:  -> { PaperSize.new( 182.mm,  257.mm).freeze },
        B6:  -> { PaperSize.new( 128.mm,  182.mm).freeze },
        B7:  -> { PaperSize.new(  91.mm,  128.mm).freeze },
        B8:  -> { PaperSize.new(  64.mm,   91.mm).freeze },
        B9:  -> { PaperSize.new(  45.mm,   64.mm).freeze },
        B10: -> { PaperSize.new(  32.mm,   45.mm).freeze },
        B11: -> { PaperSize.new(  22.mm,   32.mm).freeze },
        B12: -> { PaperSize.new(  16.mm,   22.mm).freeze },

        Letter:  -> { PaperSize.new(8.5.inch, 11.inch).freeze },
        Legal:   -> { PaperSize.new(8.5.inch, 14.inch).freeze },
        Tabloid: -> { PaperSize.new(11.inch,  17.inch).freeze }
      }.with_indifferent_access

      def paper(size)
        PaperSizes[size].call
      end

      def line(options)
        content_tag(:line, nil, options)
      end

      def rect(options)
        content_tag(:rect, nil, options)
      end

      def adjusted_text(text, options)
        letters = text.chars
        margin = -> (i) { (i * 2 + 1) * options[:width] / letters.size / 2 }
        letters.map.with_index {|letter, i|
          content_tag(:tspan, x: options[:x] + margin[i], y: options[:y], 'text-anchor' => 'middle') { letter }
        }.join.html_safe
      end
    end
  end
end
