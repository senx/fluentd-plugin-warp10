$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "fluent-plugin-warp10"
  gem.description = "fluent plugin to send metrics to Warp 10"
  gem.homepage    = "https://github.com/senx/fluentd-plugin-warp10.git"
  gem.summary     = gem.description
  gem.version     = "0.0.1"
  gem.authors     = ["SenX S.A.S."]
  gem.email       = "contact@senx.io"
  gem.has_rdoc    = false
  gem.files       = ["lib/fluent/plugin/out_warp10.rb"]
  gem.require_paths = ['lib']
  gem.add_dependency "fluentd", ">= 0.10.8"
  gem.add_development_dependency "rake", ">= 0.9.2"
end
