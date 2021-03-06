Gem::Specification.new do |spec|
  spec.name     = 'postgis_adapter'
  spec.version  = '0.9.4'
  spec.authors  = ['Marcos Piccinini', 'Matthew Jording']
  spec.summary  = 'PostGIS Adapter for Active Record'
  spec.email    = 'm@doormates.com'
  spec.homepage = 'http://github.com/doormates/postgis_adapter'


  spec.files = Dir['**/*'].reject{ |f| f.include?('git') }
  spec.test_files = Dir['spec/**/*.rb']
  spec.extra_rdoc_files  = ['README.rdoc']
  spec.add_dependency 'pg'
  spec.add_dependency 'json_pure'
  spec.add_dependency 'nofxx-georuby'

  spec.description = 'Execute PostGIS functions on Active Record'
end
