# note for self: the default port is 9292
require_relative 'overview'
disable :run
set :root, Pathname(__FILE__).dirname
run Sinatra::Application
