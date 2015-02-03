require 'nokogiri'

##
# Parses an Offer overview page from the website
class OfferOverviewParser
  ##
  # Init Nokogiri
  # @param [String, #content] content of the website
  def initialize(content)
    @page = Nokogiri::HTML.parse content
  end

  ##
  # Links to a single offer
  def offer_links
    @page.css('.claPrint.claRight a').map do |anchor|
      anchor.attributes['href'].value
    end
  end

  ##
  # Description of this Overview
  def kind
    headline = @page.css('.claMainContent .headline').text.split('-').first || 'special'
    headline.strip
  end
end
