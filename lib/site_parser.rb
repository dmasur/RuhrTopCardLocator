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
      overview_parser = OfferOverviewParser.new(agent.get(offer_overview_link).body)
      overview_parser.offer_links.each do |offer_link|
        offer_parser = OfferParser.new(agent.get(offer_link).body)
        ParseOffer.call(offer_parser, overview_parser, offer_link)
      end
    end
  end

  def self.fix_seeds
    delete_google_place_id "alpincenter Klettergarten", "ChIJ4TXSKgnpuEcR4Cz0KO0F9OU"
    delete_google_place_id "alpincenter Sommerrodelbahn", "ChIJ4TXSKgnpuEcR4Cz0KO0F9OU"
    delete_google_place_id "Kluterthöhle", "ChIJfW7uDk3RuEcRKauSXCIJrxg"
    delete_google_place_id "RVR NaturForum Bislicher Insel", "ChIJp_CZgjTduEcRpDc0h03PgPk"
    delete_google_place_id "Solebad Wischlingen", "ChIJdcLj-zoMuUcRKQabLtNaSu8"
  end

  def self.delete_google_place_id(name, place_id)
    offer = Offer.find_by name: name, google_place_id: place_id
    raise "Offer with name #{name} and place id #{place_id} not found" unless offer.present?
    offer.update_attribute :google_place_id, nil
  end
end
