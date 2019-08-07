require 'dotenv'

# CORDBOARD_ROOT = `cordboard settings | iniq "[directories]" apps`
def default_dirs
  pow_root = ENV.fetch('POW_HOST_ROOT', "#{ENV['HOME']}/.pow")
  prax_root = ENV.fetch('PRAX_HOSTS', "#{ENV['HOME']}/.prax")
  [pow_root, prax_root]
end

XDG_DATA_DIR = ENV.fetch('XDG_DATA_DIR', "#{ENV['HOME']}/.local/share")
DATA_DIR = "#{XDG_DATA_DIR}/index.dev"

APPS_DIR = Array(ENV.fetch('APPS_DIR', default_dirs))
GLOB = "{#{APPS_DIR.join(',')}}/*".freeze

ICON_PATHS = ["#{DATA_DIR}/icons"] + APPS_DIR.product(['_icons', '.icons']).map { |paths| paths.join('/') }
ICON_TYPES = %w(svg png).freeze

TLD = ENV.fetch('TLD', 'test')
HIDE_SELF = ENV.fetch('HIDE_SELF', false) == 'true'

REVERSE_DNS = ENV.fetch('REVERSE_DNS', false)
