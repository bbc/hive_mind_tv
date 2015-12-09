$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hive_mind_tv/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hive_mind_tv"
  s.version     = HiveMindTv::VERSION
  s.authors     = ["Joe Haig"]
  s.email       = ["joe.haig@bbc.co.uk"]
  s.homepage    = "https://github.com/bbc/hive_mind_tv"
  s.summary     = "TV plugin for Hive Mind"
  s.description = "The plugin for Hive Mind that deals with TV and similar devices."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.2.4"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "sqlite3"
end
