# conding: utf-8

require File.expand_path("../../../spec_helper", File.dirname(__FILE__))
require 'git/gems'
require 'minitest/spec'
require 'minitest/autorun'

describe Git::Gems::CLI do

  before do
    @instance = Git::Gems::CLI.new
  end

  describe "#install" do
    it do
      capture(:stdout) {
        @instance.invoke(:bundler, [], {})
      }.strip.must_equal("bundle install --path=./.bundle --binstubs=./.bundle/bin")
    end

    it do
      capture(:stdout) {
        @instance.invoke(:bundler, [["--test", 'fuga']], {:path => "./hoge", :binstubs => "./binhoge"})
      }.strip.must_equal("bundle install --path=./hoge --binstubs=./binhoge  --test fuga")
    end

    it do
      capture(:stdout) {
        @instance.invoke(:bundler, [], {:"production" => true})
      }.strip.must_equal("bundle install --path=./.bundle --binstubs=./.bundle/bin --without development test")
    end

    it do
      capture(:stdout) {
        @instance.invoke(:bundler, [], {:"no-path" => true})
      }.strip.must_equal("bundle install  --binstubs=./.bundle/bin")
    end

    it do
      capture(:stdout) {
        @instance.invoke(:bundler, [], {:"no-binstubs" => true})
      }.strip.must_equal("bundle install --path=./.bundle")
    end

    it do
      capture(:stdout) {
        @instance.invoke(:bundler, [], {:"no-binstubs" => true, :"no-path" => true})
      }.strip.must_equal("bundle install")
    end

    it do
      capture(:stdout) {
        @instance.invoke(:bundler, [], {path: "test", :"no-path" => true})
      }.strip.must_equal("bundle install  --binstubs=./.bundle/bin")
    end

    it do
      capture(:stdout) {
        @instance.invoke(:bundler, [], {binstubs: "test", :"no-binstubs" => true})
      }.strip.must_equal("bundle install --path=./.bundle")
    end

    it do
      capture(:stdout) {
        @instance.invoke(:bundler, [], {binstubs: "test", :"no-path" => true})
      }.strip.must_equal("bundle install  --binstubs=test")
    end

    it do
      capture(:stdout) {
        @instance.invoke(:bundler, [], {path: "test", :"no-binstubs" => true})
      }.strip.must_equal("bundle install --path=test")
    end
  end

  describe "#exec" do
    it do
      capture(:stdout) {
        @instance.invoke(:exec, ['test', ["--hoge", "bar"]], {})
      }.strip.must_equal("bundle exec test --hoge bar")
    end
  end

  describe "#init" do
    it do
      capture(:stdout) {
        @instance.invoke(:init, [], {})
      }.must_equal(<<-STRING)
cp -a #{$project_path}/fixtures/Rakefile.template ./Rakefile
cp -a #{$project_path}/fixtures/Gemfile.template ./Gemfile
cp -a #{$project_path}/fixtures/README.md.template ./README.md
mkdir -p lib spec
touch lib/.keep spec/.keep
git init
      STRING
    end
  end

end
