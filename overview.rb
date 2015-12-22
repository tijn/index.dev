#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'sass'
require 'sinatra'
require 'slim'
require 'tilt/erubis'
require 'tilt/sass'

require_relative 'app'

GLOB = "#{ENV['HOME']}/{.prax,.pow}/*"

get '/' do
  @apps = fetch_apps
  slim :'index.html'
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
