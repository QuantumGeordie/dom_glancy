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

  desc 'selenium tests'
  Rake::TestTask.new :selenium do |t|
    t.libs << '.'
    t.libs << 'test'
    t.pattern = 'test/selenium/**/*_test.rb'
  end
end

task :test => [ 'test:units', 'test:selenium' ]

task :default => :test
