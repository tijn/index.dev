#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'sass'
require 'sinatra'
require 'slim'
require 'tilt/erubis'
require 'tilt/sass'

require_relative 'app'

POW_ROOT = ENV.fetch('POW_HOST_ROOT', "#{ENV['HOME']}/.pow")
PRAX_ROOT = ENV.fetch('PRAX_HOSTS', "#{ENV['HOME']}/.prax")
POW_AND_PRAX = [POW_ROOT, PRAX_ROOT]
GLOB = "{#{POW_AND_PRAX.join(',')}}/*"
ICON_PATHS = POW_AND_PRAX.product(['_icons', '.icons']).map { |paths| paths.join('/') }

get '/' do
  @apps = fetch_apps
  slim :'index.html'
end

get '/icons/:name.png' do |name|
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
    .select { |name| File.symlink?(name) }
    .map { |name| App.new(name.split('/').last) }
    .sort
end

def detect_icon(icon)
  ICON_PATHS.lazy.map { |path| "#{path}/#{icon}.png" }.detect { |file| File.exist? file }
end
