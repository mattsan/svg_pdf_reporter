require 'rails/generators/erb/reporter/reporter_generator'

module Haml
  module Generators
    class ReporterGenerator < Erb::Generators::ReporterGenerator
      source_root File.expand_path("../templates", __FILE__)

      protected

      def handler
        :haml
      end
    end
  end
end
