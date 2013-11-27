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
  s.test_files = Dir["spec/**/*"] - Dir["spec/dummy/log/*"] - Dir["spec/dummy/solr/{data,pids}/*"]

  s.add_dependency "rails", "~> 3.2.15"
  s.add_dependency "enju_core", "~> 0.1.1.pre4"
  s.add_dependency 'paperclip', '~> 3.5'
  s.add_dependency 'state_machine'
  s.add_dependency 'enju_trunk_frbr', '~> 1.1.0'
  s.add_dependency 'active_attr'
  #s.add_dependency 'enju_trunk_message'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "vcr", "~> 2.5"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "active_attr"
end
