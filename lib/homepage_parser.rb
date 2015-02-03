require 'nokogiri'

##
# Parses the main webpage
class HomepageParser
  # Init nokogiri
  # @param [String, #content] content of the website
  def initialize(content)
    @page = Nokogiri::HTML.parse content
  end

  ##
  # Links to the offer overview pages
  def offer_overview_links
    links = @page.css('.claLeft.claNoPrint a').map { |anchor| anchor.attributes['href'].value }
    links_found = links.select { |link| link.include? 'angebot' }
    raise 'Offer Overview Links not found' if links_found.count != 3
    links_found
  end
end
