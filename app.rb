class App
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def url
    "//#{name}.dev"
  end

  def icon
    "#{name}.png"
  end

  def to_s
    name
  end

  def <=>(other)
    domain_for_sorting <=> other.domain_for_sorting
  end

  def domain_for_sorting
    @domain_for_sorting ||= to_s.split('.').reverse
  end
end
