require 'homepage_parser'
require 'offer_overview_parser'
require 'offer_parser'

##
# Parse the main website and save all offers in database
class SiteParser
  ##
  # Shortcut
  def self.parse_from_website
    new.parse_from_website
  end

  ##
  # Parse the hole website and save offers
  def parse_from_website
    Logger.info 'Parsing from Website:'
    offer_overview_links = HomepageParser.new(get_body_from('/index.php')).offer_overview_links
    offer_overview_links.each do |offer_overview_link|
      overview_parser = OfferOverviewParser.new(get_body_from(offer_overview_link))
      overview_parser.offer_links.each do |offer_link|
        create_and_parse_offer(offer_link, overview_parser)
      end
    end
    Logger.info
  end

  private

  ##
  # Create and parse one offer
  def create_and_parse_offer(offer_link, overview_parser)
    offer_parser = OfferParser.new(get_body_from(offer_link))
      Logger.info offer_parser.name
    offer = Offer.find_or_create_by(name: offer_parser.name)
    offer.url = offer_link
    ParseOffer.call(offer_parser, overview_parser, offer)
    UpdateOffer.place_id(offer)
  end

  ##
  # Get the content of an Page
  def get_body_from(path)
    Net::HTTP.get('www.ruhrtopcard.de', path)
  end
end
