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

    describe "#release" do
      it do
        expect(capture(:stdout) {
          @instance.invoke(:release, [], {})
        }).to match(/git tag -a 'release-[0-9]{12}'/)
      end
      it do
        expect(capture(:stdout) {
          @instance.invoke(:release, [], {:version => 'hoge'})
        }.strip).to eq("git tag -a 'release-hoge'")
      end
      it do
        expect(capture(:stdout) {
          @instance.invoke(:release, [], {:version => 'fuga', :push => true})
        }).to eq(<<-STRING)
git tag -a 'release-fuga'
git push origin --tags
        STRING
      end
    end

  end
end
