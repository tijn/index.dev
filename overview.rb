#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'sass'
require 'sinatra'
require 'slim'
require 'tilt/erubis'
require 'tilt/sass'

require_relative 'models/app'
require_relative 'models/domain_name'

POW_ROOT = ENV.fetch('POW_HOST_ROOT', "#{ENV['HOME']}/.pow")
PRAX_ROOT = ENV.fetch('PRAX_HOSTS', "#{ENV['HOME']}/.prax")
POW_AND_PRAX = [POW_ROOT, PRAX_ROOT].freeze
GLOB = "{#{POW_AND_PRAX.join(',')}}/*".freeze
ICON_PATHS = POW_AND_PRAX.product(['_icons', '.icons']).map { |paths| paths.join('/') }
ICON_TYPES = %w(svg png).freeze

get '/' do
  @apps = fetch_apps
  slim :index
end

get '/icons/:name' do |name|
  full_path = detect_icon(name)
  raise Sinatra::NotFound if full_path.nil?
  last_modified File.mtime(full_path)
  send_file full_path
end

get '/the_index.css' do
  sass :the_index
end

def fetch_apps
  Dir.glob(GLOB)
     .reject { |name| name =~ /^\.|\_/ }
     .map { |name| App.new(name.split('/').last) }
     .sort
end

def possible_icon_paths(name)
  DomainName.new(name).with_parents.lazy.flat_map do |domain|
    ICON_PATHS.lazy.select { |path| File.exist? path }.flat_map do |path|
      ICON_TYPES.lazy.flat_map { |type| "#{path}/#{domain}.#{type}" }
    end
  end
end

def detect_icon(name)
  possible_icon_paths(name).detect { |filename| File.exist? filename }
end
