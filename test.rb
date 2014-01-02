#!/usr/bin/env ruby

require "open3"

puts "Hello world"
puts "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"

stdin, stdout, stderr = Open3.popen3('bc')
stdin.puts('5 + 10')
puts stdout.gets
