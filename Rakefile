require 'rake/testtask'
require "bundler/gem_tasks"

namespace :test do
  desc 'unit tests'
  Rake::TestTask.new :units do |t|
    t.libs << '.'
    t.libs << 'test'
    t.pattern = 'test/unit/**/*_test.rb'
    t.verbose = true
  end

  desc 'mapping tests'
  Rake::TestTask.new :mapping do |t|
    t.libs << '.'
    t.libs << 'test'
    t.pattern = 'test/mapping/**/*_test.rb'
  end
end

task :test => [ 'test:units' ]

task :default => :test
