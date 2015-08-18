# spec_helper file.
$: << File.expand_path('../lib', File.dirname(__FILE__))
$project_path = "#{File.expand_path("../", File.dirname(__FILE__))}"

require 'stringio'
require 'git/gems'
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


class Git::Gems::CLI
  private
  def exec_cmd(command)
    puts command
  end
end


$project_path = "#{File.expand_path("../", File.dirname(__FILE__))}"

__END__
