require 'homepage_parser'
require 'offer_overview_parser'
require 'offer_parser'
require 'mechanize'

##
# Parse the main website and save all offers in database
class SiteParser
  def self.parse_from_website
    puts "Parsing from Website:"
    agent = Mechanize.new
    page = agent.get('http://www.ruhrtopcard.de')
    homepage_parser = HomepageParser.new(page.body)
    homepage_parser.offer_overview_links.each do |offer_overview_link|
      overview_parser = OfferOverviewParser.new(agent.get(offer_overview_link).body)
      overview_parser.offer_links.each do |offer_link|
        print '.'
        offer_parser = OfferParser.new(agent.get(offer_link).body)
        offer = Offer.find_or_create_by(name: offer_parser.name)
        offer.url = offer_link
        ParseOffer.call(offer_parser, overview_parser, offer)
        UpdateOffer.place_id(offer)
      end
    end
    puts "Finished"
  end

  def self.fix_seeds
    puts "Fixing Seeds"
    delete_google_place_id "alpincenter Klettergarten", "ChIJ4TXSKgnpuEcR4Cz0KO0F9OU"
    delete_google_place_id "alpincenter Sommerrodelbahn", "ChIJ4TXSKgnpuEcR4Cz0KO0F9OU"
    delete_google_place_id "Kluterthöhle", "ChIJfW7uDk3RuEcRKauSXCIJrxg"
    delete_google_place_id "RVR NaturForum Bislicher Insel", "ChIJp_CZgjTduEcRpDc0h03PgPk"
    delete_google_place_id 'Mülheimer Wikingerschiff - "MüWi"', "ChIJZbOMyfXAuEcRdWcCU4J79Hs"
    delete_google_place_id 'ExtraSchicht – Die Nacht der Industriekultur 2014', "ChIJhYwhvdENuUcR38d8F15Vn9k"
    delete_google_place_id 'Klavier-Festival Ruhr', "ChIJzWe8tM3CuEcRA6lBkuOTfQM"
    delete_google_place_id 'SISTER ACT - Das Broadway Musical', "ChIJmXcSs7DdsUcRHm6KZmysO50"
    delete_google_place_id "outdoorcenter nrw/ Hochseilgarten Isselburg", "ChIJQQtB6Ih9uEcRa_n_AzTTlzE"
    delete_google_place_id 'Personenschifffahrt Schmidt - MS Kemnade', "ChIJjTnli1DYnUcRPnW_kFpqkRc"
    update_google_place_id "AQUApark",
      from_place_id: "ChIJRVviqn8K_UYRCm6pACHIHNI", to_place_id: "ChIJgx1_kW_quEcRtS1shUXqFbE"
    update_google_place_id "Platsch",
      from_place_id: "ChIJO0VnXomfb0cR8-NEdaWMJaI", to_place_id: "ChIJ043bMWYluUcRvZMeyP4WDfw"
    update_google_place_id "Stiftung Eisenbahnmuseum Bochum",
      from_place_id: "ChIJiyaePdHduEcRLGmYi3cJDrE", to_place_id: "ChIJe3p0rnneuEcRz0-4sWgxIOA"
    update_google_place_id "Domschatz Essen",
      from_place_id: "ChIJuw-8LbTCuEcRU4cxLdQ5ox4", to_place_id: "ChIJuw-8LbTCuEcRU4cxLdQ5ox4"
    update_google_place_id "Ruhr Museum und Portal der Industriekultur",
      from_place_id: "ChIJeTlT4b8euUcRQbN1KoXtOSA", to_place_id: "ChIJiZ9p4O7nuEcRkH9AEqEKyFs"
    update_google_place_id "Up & Away - Outdoor und mehr ... Klettern leicht gemacht für Einsteiger",
      from_place_id: "ChIJFb_galrDmUcRKfRTEmspLd0", to_place_id: "ChIJ6y8dFNbwuEcRoXHLIxjIyBM"
  end

  def self.delete_google_place_id(name, place_id)
    update_google_place_id(name, from_place_id: place_id, to_place_id: nil)
  end

  def self.update_google_place_id(name, from_place_id:, to_place_id:)
    offer = Offer.find_by name: name, google_place_id: from_place_id
    raise "Offer with name #{name} and place id #{from_place_id} not found" unless offer.present?
    offer.update_attribute :google_place_id, to_place_id
  end
end
