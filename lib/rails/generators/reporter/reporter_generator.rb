module Rails
  module Generators
    class ReporterGenerator < Rails::Generators::NamedBase
      source_root File.expand_path('../templates', __FILE__)

      argument :actions, type: :array, default: [], banner: 'method method'

      def create_reporter_file
        template "reporter.rb", File.join('app/reporters', class_path, "#{file_name}_reporter.rb")

        in_root do
          if self.behavior == :invoke && !File.exist?(application_reporter_file_name)
            template 'application_reporter.rb', application_reporter_file_name
          end
        end
      end

      hook_for :template_engine

      protected

      def file_name
        @_file_name ||= super.gsub(/_reporter/i, '')
      end

      private

      def application_reporter_file_name
        @_application_reporter_file_name ||=
          if mountable_engine?
            "app/reporters/#{namespaced_path}/application_reporter.rb"
          else
            "app/reporters/application_reporter.rb"
          end
      end
    end
  end
end
