require_relative 'app_name_presenter'

# an Application that Pow/Prax can start
# name should be the basename of a file or a symlink in ~/{.prax,.pow}/
class App
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def url
    "//#{name}.dev" # leaving out the scheme
  end

  def to_s
    name.tr('_', ' ')
  end

  def to_html
    AppNamePresenter.new(name).to_html
  end

  def <=>(other)
    domain_for_sorting <=> other.domain_for_sorting
  end

  def domain_for_sorting
    @domain_for_sorting ||= domain_parts.reverse
  end

  def domain_parts
    name.split('.')
  end
end
