describe Git::Gems::CLI do
  context "success" do

    before(:each) do
      @instance = Git::Gems::CLI.new
    end

    describe "#install" do
      it do
        expect(capture(:stdout) {
          @instance.invoke(:install, [], {})
        }).to eq("bundle install --path=./.bundle --binstubs=./.bundle/bin \n")
      end

      it do
        expect(capture(:stdout) {
          @instance.invoke(:install, [["--test", 'fuga']], {:path => "./hoge", :binstubs => "./binhoge"})
        }).to eq("bundle install --path=./hoge --binstubs=./binhoge --test fuga\n")
      end
    end

    describe "#exec" do
      it do
        expect(capture(:stdout) {
          @instance.invoke(:exec, ['test', ["--hoge", "bar"]], {})
        }).to eq("bundle exec test --hoge bar\n")
      end
    end

    describe "#init" do
      it do
        expect(capture(:stdout) {
          @instance.invoke(:init, [], {})
        }).to eq(<<-STRING
cp -a /home/travis/build/magicdrive/ruby-git-gems/fixtures/Rakefile.template ./Rakefile
cp -a /home/travis/build/magicdrive/ruby-git-gems/fixtures/Gemfile.template ./Gemfile
cp -a /home/travis/build/magicdrive/ruby-git-gems/fixtures/README.md.template ./README.md
mkdir -p lib spec
touch lib/.keep spec/.keep
git init
                STRING
        )
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
        }).to eq("git tag -a 'release-hoge'\n")
      end
      it do
        expect(capture(:stdout) {
          @instance.invoke(:release, [], {:version => 'fuga', :push => true})
        }).to eq(<<-STRING
git tag -a 'release-fuga'
git push origin --tags
        STRING
        )
      end
    end

  end
end
