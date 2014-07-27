# coding: utf-8

require 'rubygems'
require 'bundler/setup'
require "git/gems/version"
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
          binstubs_path = options[:binstubs]
          binstubs_path = "./.bundle/bin"
          return binstubs_path
        end
      end

      public
      option :path,     :alias => "-p", :default => default_install_path()
      option :binstubs, :alias => "-b", :default => default_binstubs_path()
      desc "git gems install [OPTIONS]",""
      def install(*args)
        pid = spawn(
          "bundle install --path=#{options[:path]} --binstubs=#{options[:binstubs]} #{args.join(%{ })}"
        )
        Process::wait(pid)
      end
      default_task :install

      desc 'git gems exec [COMMAND] [OPTIONS]',''
      def exec(cmd, *args)
        pid = spawn(
          "bundle exec #{cmd} #{args.join(%{ })}"
        )
        Process::wait(pid)
      end

      def method_missing(name, *args)
        self.__send__(:exec, name, *args)
      end

    end
  end
end
