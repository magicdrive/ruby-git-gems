![Build Status](https://travis-ci.org/magicdrive/ruby-git-gems.svg?branch=feature%2Frspec)
# Git::Gems

my bundler and git wrapper.  (thor based)



## Installation

Add this line to your application's Gemfile:

	gem 'git-gems'

And then execute:

	$ bundle

Or install it yourself as:

	$ gem install git-gems

## Usage

	git gems [OPTION]

`install` command (default):
Set automatically `--path` option it is determined whether the rack app.

	git gems	
    #or
	git gems install 

`init` command:  
Customized just for a moment or `bundle gem` is` bundle init`. 
make a template of the repository nor a rack app without also be of gem.

    git gems init

`release` command:  
taged for release. Tag name is the default YYYYMMDDHHmm.

    git gems release [--version][version_name]

`exec` command:  
The runs are passed to the bundle exec option if it does not support came over. Argument is also in accordance with the rules of the `bundle exec`.

    git gems [command]
    # or
    git gems exec [command]
    



## Contributing

1. Fork it ( https://github.com/[my-github-username]/git-gems/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
