class DomainName
  DOT = '.'.freeze
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  alias to_s name

  def parts
    @parts ||= name.split(DOT)
  end

  # parts are officially called labels
  # https://en.wikipedia.org/wiki/Domain_name#Domain_name_syntax
  alias labels parts
  alias to_a parts

  def top_level_domain?
    parts.size == 1
  end

  alias tld? top_level_domain?

  def parent
    return if top_level_domain?
    DomainName.new parts[1..-1].join(DOT)
  end

  # DomainName.new('www.example.com').with_parents.map(&:to_s)
  # => ["www.example.com", "example.com", "com"]
  def with_parents
    return [self] if top_level_domain?
    [self, parent.with_parents].flatten
  end
end
