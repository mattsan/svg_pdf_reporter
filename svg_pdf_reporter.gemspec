$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "svg_pdf_reporter/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "svg_pdf_reporter"
  s.version     = SvgPdfReporter::VERSION
  s.authors     = ["Eiji MATSUMOTO"]
  s.email       = ["e.mattsan@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of SvgPdfReporter."
  s.description = "TODO: Description of SvgPdfReporter."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.6"

  s.add_development_dependency "sqlite3"
end
