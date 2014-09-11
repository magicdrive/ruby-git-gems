# coding: utf-8
require "bundler/gem_tasks"
require "bundler/setup"

task :default => [:spec]

begin
  require 'rspec/core/rake_task'
  require 'rspec'
  require 'rr'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = ['-c', '-f progress', '-r ./spec/spec_helper.rb']
    t.pattern = 'spec/**/*_spec.rb'
  end
  RSpec.configure do |config|
    config.mock_with :rr
    # config.mock_with RR::Adapters::Rspec
  end
rescue LoadError => e
end
