 require 'homepage_parser'
require 'offer_parser'

##
# Parse the main website and save all offers in database
class SiteParser
  ##
  # Shortcut
  def self.parse_from_website
    new.parse_from_website
  end

  def log(message = nil)
    @logger ||= Logger.new(STDOUT)
    @logger.info message
  end

  ##
  # Parse the hole website and save offers
  def parse_from_website
    log 'Parsing from Website:'
    prefix = "/leistungen/alle-leistungen-2016/"
    offer_links = HomepageParser.new(get_body_from(prefix + 'index.html')).offer_links
    offer_links.each do |offer_link|
      create_and_parse_offer('/' + offer_link)
    end
    log
  end

  private

  ##
  # Create and parse one offer
  def create_and_parse_offer(offer_link)
    offer_parser = OfferParser.new(get_body_from(offer_link))
    log offer_parser.name
    offer = Offer.find_or_create_by(name: offer_parser.name)
    offer.url = offer_link
    ParseOffer.call(offer_parser, offer)
    #UpdateOffer.place_id(offer)
  end

  ##
  # Get the content of an Page
  def get_body_from(path)
    Net::HTTP.get('www.ruhrtopcard.de', path)
    #Net::HTTP.get('localhost', path, 8000)
  end
end
