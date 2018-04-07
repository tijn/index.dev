#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'json'
require 'sass'
require 'sinatra'
require 'slim'
require 'tilt/erubis'
require 'tilt/sass'

require_relative 'config/setup'
require_relative 'models/app'
require_relative 'models/domain_name'

DEFAULT_ICON_PATH = "#{__dir__}/public/bulb.svg"

get '/' do
  @apps = fetch_apps
  slim :index
end

get '/index.json' do
  @apps = fetch_apps
  @apps.to_json
end

get '/icons/:name' do |name|
  full_path = detect_icon(name) || DEFAULT_ICON_PATH
  # raise Sinatra::NotFound if full_path.nil?
  last_modified File.mtime(full_path)
  send_file full_path
end

get '/the_index.css' do
  sass :the_index
end

HIDDEN_DIR = ['.', '_']
def hidden_entry?(name)
  HIDDEN_DIR.include? name[0]
end

def hide_self?(name)
  return false unless HIDE_SELF
  request.host == "#{name}.#{TLD}"
end

def fetch_apps
  Dir.glob(GLOB)
     .map { |name| name.split('/').last }
     .reject { |name| hidden_entry?(name) || hide_self?(name) }
     .map { |name| App.new(name) }
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
