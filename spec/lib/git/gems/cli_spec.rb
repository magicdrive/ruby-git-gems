# conding: utf-8

describe Git::Gems::CLI do
  context "success" do

    before(:each) do
      @instance = Git::Gems::CLI.new
    end

    describe "#install" do
      it do
        expect(capture(:stdout) {
          @instance.invoke(:bundler, [], {})
        }.strip).to eq("bundle install --path=./.bundle --binstubs=./.bundle/bin")
      end

      it do
        expect(capture(:stdout) {
          @instance.invoke(:bundler, [["--test", 'fuga']], {:path => "./hoge", :binstubs => "./binhoge"})
        }.strip).to eq("bundle install --path=./hoge --binstubs=./binhoge  --test fuga")
      end

      it do
        expect(capture(:stdout) {
          @instance.invoke(:bundler, [], {:"production" => true})
        }.strip).to eq("bundle install --path=./.bundle --binstubs=./.bundle/bin --without development test")
      end

      it do
        expect(capture(:stdout) {
          @instance.invoke(:bundler, [], {:"no-path" => true})
        }.strip).to eq("bundle install  --binstubs=./.bundle/bin")
      end

      it do
        expect(capture(:stdout) {
          @instance.invoke(:bundler, [], {:"no-binstubs" => true})
        }.strip).to eq("bundle install --path=./.bundle")
      end

      it do
        expect(capture(:stdout) {
          @instance.invoke(:bundler, [], {:"no-binstubs" => true, :"no-path" => true})
        }.strip).to eq("bundle install")
      end

      it do
        expect(capture(:stdout) {
          @instance.invoke(:bundler, [], {path: "test", :"no-path" => true})
        }.strip).to eq("bundle install  --binstubs=./.bundle/bin")
      end

      it do
        expect(capture(:stdout) {
          @instance.invoke(:bundler, [], {binstubs: "test", :"no-binstubs" => true})
        }.strip).to eq("bundle install --path=./.bundle")
      end

      it do
        expect(capture(:stdout) {
          @instance.invoke(:bundler, [], {binstubs: "test", :"no-path" => true})
        }.strip).to eq("bundle install  --binstubs=test")
      end

      it do
        expect(capture(:stdout) {
          @instance.invoke(:bundler, [], {path: "test", :"no-binstubs" => true})
        }.strip).to eq("bundle install --path=test")
      end
    end

    describe "#exec" do
      it do
        expect(capture(:stdout) {
          @instance.invoke(:exec, ['test', ["--hoge", "bar"]], {})
        }.strip).to eq("bundle exec test --hoge bar")
      end
    end

    describe "#init" do
      it do
        expect(capture(:stdout) {
          @instance.invoke(:init, [], {})
        }).to eq(<<-STRING)
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
  describe "#install" do
      it do
        expect(capture(:stdout) {
          @instance.invoke(:release, [], {})
        }).to eq('bundle update')
      end

  end
end
