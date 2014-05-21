# encoding: utf-8

lib = File.expand_path( '../lib/', __FILE__ )
$:.unshift lib unless $:.include?( lib )

VERSION = File.open("VERSION", 'r').read

Gem::Specification.new do |s|
  s.name = "rack-isocode"
  s.license = 'MIT'
  s.author = "Jason Benterou"
  s.email = "jason.benterou@gmail.com"
  s.files = `git ls-files`.split("\n")
  s.date = `git show -s --format=%ci HEAD`.split(" ").first
  s.homepage = "https://github.com/jtwb/rack-isocode"
  s.platform = Gem::Platform::RUBY
  s.require_paths = [ "lib" ]

  s.required_rubygems_version = Gem::Requirement.new('>= 1.3.6') if s.respond_to?( :required_rubygems_version= )
  s.summary = "Isocode for Rack"
  s.version = VERSION
end
