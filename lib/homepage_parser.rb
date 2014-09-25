require 'nokogiri'

##
# Parses the main webpage
class HomepageParser
  def initialize(content)
    @page = Nokogiri::HTML.parse content
  end

  def offer_overview_links
    links = @page.css('.claLeft.claNoPrint a').map { |anchor| anchor.attributes['href'].value }
    links.select { |link| link.include? 'angebot' }
  end
end
