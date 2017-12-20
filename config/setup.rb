require 'dotenv'

POW_ROOT = ENV.fetch('POW_HOST_ROOT', "#{ENV['HOME']}/.pow")
PRAX_ROOT = ENV.fetch('PRAX_HOSTS', "#{ENV['HOME']}/.prax")
POW_AND_PRAX = [POW_ROOT, PRAX_ROOT].freeze
GLOB = "{#{POW_AND_PRAX.join(',')}}/*".freeze
ICON_PATHS = POW_AND_PRAX.product(['_icons', '.icons']).map { |paths| paths.join('/') }
ICON_TYPES = %w(svg png).freeze
TLD = ENV.fetch('TLD', 'test')
HIDE_SELF = ENV.fetch('HIDE_SELF', false) == 'true'
