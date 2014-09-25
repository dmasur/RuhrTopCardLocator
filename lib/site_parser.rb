require 'homepage_parser'
require 'offer_overview_parser'
require 'offer_parser'
require 'mechanize'

##
# Parse the main website and save all offers in database
class SiteParser
  def self.parse_from_website
    agent = Mechanize.new
    page = agent.get('http://www.ruhrtopcard.de')
    homepage_parser = HomepageParser.new(page.body)
    homepage_parser.offer_overview_links.each do |offer_overview_link|
      OfferOverviewParser.new(agent.get(offer_overview_link).body).offer_links.each do |offer_link|
        offer_parser = OfferParser.new(agent.get(offer_link).body)
        ParseOffer.call(offer_parser)
      end
    end
  end
end
