$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "enju_trunk_inventory/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "enju_trunk_inventory"
  s.version     = EnjuTrunkInventory::VERSION
  s.authors     = ["Akifumi NAKAMURA"]
  s.email       = ["nakamura.akifumi@miraitsystems.jp"]
  s.homepage    = "https://github.com/nakamura-akifumi/enju_trunk"
  s.summary     = "Inventory plugin for Enju Trunk."
  s.description = "inventory plugin."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "pg"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "simplecov"
end
