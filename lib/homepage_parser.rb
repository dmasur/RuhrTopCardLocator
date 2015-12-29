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
  def offer_links
    @page.css('.service-list-item a').map { |anchor| anchor.attributes['href'].value }
  end
end
