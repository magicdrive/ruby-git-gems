# coding: utf-8

require 'rubygems'
require 'bundler/setup'
require 'thor'

module Git
  module Gems
    class CLI < Thor
      class << self
        def is_rackapp?
          return File.exist?(File.expand_path("./config.ru"))
        end

        def default_install_path()
          install_path = options[:path]
          install_path = is_rackapp? ?
            "./vendor/bundle" : "./.bundle" if install_path.nil?
          return install_path
        end

        def default_binstubs_path()
          return "./.bundle/bin"
        end
      end

      public
      option :path,     :alias => "-p", :default => default_install_path
      option :binstubs, :alias => "-b", :default => default_binstubs_path
      desc "git gems install [OPTIONS]",""
      def install(*args)
        exec_cmd "bundle install --path=#{options[:path]} --binstubs=#{options[:binstubs]} #{args.join(%{ })}"
      end
      default_task :install

      desc 'git gems exec [COMMAND] [OPTIONS]',''
      def exec(cmd, *args)
        exec_cmd "bundle exec #{cmd} #{args.join(%{ })}"
      end

      desc 'git gems init',''
      def init()
        %w(Rakefile Gemfile README.md).each do |f|
          exec_cmd "cp -a #{File.expand_path("../fixtures/#{template_file}.template", __FILE__)} ./"
        end
        exec_cmd "mkdir -p lib spec"
        exec_cmd "git init"
      end

      option :version,     :alias => "-v", :default => Time.now.strftime("%Y%m%d%H%M")
      desc 'git gems release_tag', ''
      def release_tag
        exec_cmd "git tag -a 'release-#{options[:version]}' -v"
      end

      private
      def exec_cmd(command)
        pid = spawn(command.to_s)
        Process::wait(pid)
      end

      def method_missing(name, *args)
        self.__send__(:exec, name, *args)
      end

    end
  end
end
