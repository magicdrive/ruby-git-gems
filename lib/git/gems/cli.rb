# coding: utf-8

require 'rubygems'
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
      option :path,      :default => default_install_path
      option :binstubs,  :default => default_binstubs_path
      desc "install [OPTIONS]","do bundle install."
      def install(*args)
        exec_cmd "bundle install --path=#{options[:path]} --binstubs=#{options[:binstubs]} #{args.join(%{ })}"
      end
      default_task :install

      desc 'exec [COMMAND] [OPTIONS]','do bundle exec .'
      def exec(cmd, *args)
        exec_cmd "bundle exec #{cmd} #{args.join(%{ })}"
      end

      desc 'init','initilalize ruby project'
      def init()
        %w(Rakefile Gemfile README.md).each do |f|
          exec_cmd "cp -a #{File.expand_path("../../../../fixtures/#{f}.template", __FILE__)} ./#{f}"
        end
        exec_cmd "mkdir -p lib spec"
        exec_cmd "touch lib/.keep spec/.keep"
        exec_cmd "git init"
      end

      option :version, :default => Time.now.strftime("%Y%m%d%H%M")
      option :push, :type => :boolean
      desc 'release [--version] [version_name]', 'taged release-tag'
      def release
        exec_cmd "git tag -a 'release-#{options[:version]}'"
        exec_cmd "git push origin --tags" if options[:push]
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
