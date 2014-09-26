require 'nokogiri'

##
# Parses an Offer overview page from the website
class OfferOverviewParser
  def initialize(content)
    @page = Nokogiri::HTML.parse content
  end

  def offer_links
    @page.css('.claPrint.claRight a').map do |anchor|
      anchor.attributes['href'].value
    end
  end

  def kind
    @page.css('.headline').text.split('-').first.strip
  end
end
