# frozen_string_literal: true

require "bundler"
Bundler::GemHelper.install_tasks

# require "rspec/core/rake_task"
# RSpec::Core::RakeTask.new

require "rake/testtask"
Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
  t.warning = false
end

require "rubocop/rake_task"
RuboCop::RakeTask.new

task default: %i[test rubocop]
