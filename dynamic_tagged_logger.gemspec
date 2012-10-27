# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.authors       = ["av"]
  gem.email         = ["av@fun-box.ru"]
  gem.description   = %q{Simple tagged logger extention to provide dynamically calculated tags for each log line}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "dynamic_tagged_logger"
  gem.require_paths = ["lib"]
  gem.version       = "0.0.1"

  gem.add_runtime_dependency("rails", "~> 3.2")
end
