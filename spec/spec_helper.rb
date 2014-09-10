# spec_helper file.
require File.expand_path('../lib/git/gems', File.dirname(__FILE__))
require 'stringio'
require 'pry'

def capture(stream)
  begin
    stream = stream.to_s
    eval "$#{stream} = StringIO.new"
    yield
    result = eval("$#{stream}").string
  ensure
    eval("$#{stream} = #{stream.upcase}")
  end
  return result
end


##################class Git::Gems::CLI
##################  private
##################  def exec_cmd(command)
##################    puts command
##################  end
##################end
