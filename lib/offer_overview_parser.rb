require 'nokogiri'

class OfferOverviewParser
  def initialize(content)
    @page = Nokogiri::HTML.parse content
  end

  def offer_links
    @page.css('.claPrint.claRight a').map do |anchor|
      anchor.attributes['href'].value
    end
  end
end