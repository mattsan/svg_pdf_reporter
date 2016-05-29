require 'rails/generators/erb'

module Erb
  module Generators
    class ReporterGenerator < Base
      source_root File.expand_path("../templates", __FILE__)
      argument :actions, type: :array, default: [], bunner: 'action action'

      def copy_view_files
        base_path = File.join('app/views', class_path, file_name)
        empty_directory base_path

        if self.behavior == :invoke
          layout_path = File.join('app/views/layouts', filename_with_extensions(:reporter, :svg))
          template filename_with_extensions(:layout, :svg), layout_path
        end

        actions.each do |action|
          @action = action
          @path = File.join(base_path, filename_with_extensions(action, :svg))
          template filename_with_extensions(:view, :svg), @path
        end
      end
    end
  end
end
