# coding: utf-8

require 'rubygems'
require 'thor'

module Git
  module Gems
    class CLI < Thor

      class << self
        def has_vendor_dir?
          return File.exist?(File.expand_path("./config.ru")) && Dir.exist?(File.expand_path("./vendor"))
        end

        def default_install_path()
          install_path = options[:path]
          install_path = has_vendor_dir? ?
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
      option :"no-binstubs",  type: :boolean, default: false
      option :"no-path",  type: :boolean, default: false
      option :global,  type: :boolean, default: false
      option :production,  type: :boolean, default: false
      desc "bundler [OPTIONS]","do bundle install."
      def bundler(*args)
        options[:"no-path"], options[:"no-binstubs"] = true if options[:global]
        group_opt    = options[:production] ? "--without development test" : %{}
        path_opt     = options[:"no-path"] ? %{} : "--path=#{options[:path]}"
        binstubs_opt = options[:"no-binstubs"] ? %{} : "--binstubs=#{options[:binstubs]}"

        exec_cmd "bundle install #{path_opt} #{binstubs_opt} #{group_opt} #{args.join(%{ })}"
      end
      default_task :bundler

      desc 'exec [COMMAND] [OPTIONS]','do bundle exec .'
      def exec(cmd, *args)
        exec_cmd "bundle exec #{cmd} #{args.join(%{ })}"
      end

      desc 'init','initilalize ruby project'
      def init()
        %w(Rakefile Gemfile README.md).each do |f|
          exec_cmd "cp -a #{File.expand_path("../../../fixtures/#{f}.template", File.dirname(__FILE__))} ./#{f}"
        end
        exec_cmd "mkdir -p lib spec"
        exec_cmd "touch lib/.keep spec/.keep"
        exec_cmd "git init"
      end

      desc 'update', 'update bundled gems'
      def update(*args)
        exec_cmd "bundle update #{args.join(%{ })}"
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
