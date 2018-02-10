# an Application that Pow/Prax can start
# name should be the basename of a file or a symlink in ~/{.prax,.pow}/
class App
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def url
    "//#{name}.#{TLD}" # leaving out the scheme
  end

  def to_s
    name.force_encoding('utf-8')
    name.tr('_', ' ').gsub('.', "\u200b.")
  end

  def <=>(other)
    domain_for_sorting <=> other.domain_for_sorting
  end

  def domain_for_sorting
    @domain_for_sorting ||= to_s.split('.').reverse
  end

  def to_json(*a)
    { name: name, url: url }.to_json(*a)
  end
end
