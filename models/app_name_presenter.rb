require 'cgi'

class AppNamePresenter
  # It's not exactly semver but I cannot simply use the semver regexp since I expect dashes to be used instead of dots.
  # It seems to be "good enough"™
  VERSION_PREFIX = /(?<=&nbsp;)/ # only match strings preceded by a space
  VERSION = /#{VERSION_PREFIX}(\d+\-)((alpha|beta|gamma|omega)?\d+\-?)+$/

  DOT_LOOKAHEAD = /(?=\.)/

  def initialize(name)
    @domain = "#{name}.dev"
    @parts = @domain.split(DOT_LOOKAHEAD) # split but keep the delimeter chars
  end

  def to_html
    span('name', formatted_parts)
  end

  def formatted_parts(parts = @parts)
    parts.map { |part| span('name__part', format_part(part)) }.join('<wbr>')
  end

  def format_part(part)
    part = h(part)
    part.gsub!('_', '&nbsp;')
    part.gsub!(VERSION) { |version| span('name__version', version.tr('-', '.')) }
    part
  end

  def h(text)
    CGI.escapeHTML(text)
  end

  private

  # watch out! The klass will be html escaped but the content is expected to already be escaped.
  def span(klass, content = nil)
    content ||= yield
    "<span class='#{h(klass)}'>#{content}</span>"
  end
end
