require 'homepage_parser'
require 'offer_overview_parser'
require 'offer_parser'
require 'mechanize'

##
# Parse the main website and save all offers in database
class SiteParser
  def self.parse_from_website
    puts 'Parsing from Website:'
    HomepageParser.new(get_body_from('http://www.ruhrtopcard.de')).offer_overview_links.each do |offer_overview_link|
      overview_parser = OfferOverviewParser.new(get_body_from(offer_overview_link))
      overview_parser.offer_links.each do |offer_link|
        print '.'
        offer_parser = OfferParser.new(get_body_from(offer_link))
        offer = find_or_init_offer(offer_parser.name)
        ParseOffer.call(offer_parser, overview_parser, offer)
        UpdateOffer.place_id(offer)
      end
    end
  end

  def self.find_or_init_offer(name)
    Offer.find_or_create_by(name: name)
    offer.url = offer_link
    offer
  end

  def self.get_body_from(url)
    @agent ||= Mechanize.new
    @agent.get(url)
  end

  def self.fix_seeds
    puts 'Fixing Seeds'
    delete_google_place_ids
    update_google_place_ids
  end

  def self.update_google_place_ids
    update_google_place_id 'AQUApark',
                           from_place_id: 'ChIJRVviqn8K_UYRCm6pACHIHNI', to_place_id: 'ChIJgx1_kW_quEcRtS1shUXqFbE'
    update_google_place_id 'Platsch',
                           from_place_id: 'ChIJO0VnXomfb0cR8-NEdaWMJaI', to_place_id: 'ChIJ043bMWYluUcRvZMeyP4WDfw'
    update_google_place_id 'Stiftung Eisenbahnmuseum Bochum',
                           from_place_id: 'ChIJiyaePdHduEcRLGmYi3cJDrE', to_place_id: 'ChIJe3p0rnneuEcRz0-4sWgxIOA'
    update_google_place_id 'Domschatz Essen',
                           from_place_id: 'ChIJuw-8LbTCuEcRU4cxLdQ5ox4', to_place_id: 'ChIJuw-8LbTCuEcRU4cxLdQ5ox4'
    update_google_place_id 'Ruhr Museum und Portal der Industriekultur',
                           from_place_id: 'ChIJeTlT4b8euUcRQbN1KoXtOSA', to_place_id: 'ChIJiZ9p4O7nuEcRkH9AEqEKyFs'
    update_google_place_id 'Up & Away - Outdoor und mehr ... Klettern leicht gemacht für Einsteiger',
                           from_place_id: 'ChIJFb_galrDmUcRKfRTEmspLd0', to_place_id: 'ChIJ6y8dFNbwuEcRoXHLIxjIyBM'
  end

  def self.delete_google_place_ids
    delete_google_place_id 'alpincenter Klettergarten', 'ChIJ4TXSKgnpuEcR4Cz0KO0F9OU'
    delete_google_place_id 'alpincenter Sommerrodelbahn', 'ChIJ4TXSKgnpuEcR4Cz0KO0F9OU'
    delete_google_place_id 'Kluterthöhle', 'ChIJfW7uDk3RuEcRKauSXCIJrxg'
    delete_google_place_id 'RVR NaturForum Bislicher Insel', 'ChIJp_CZgjTduEcRpDc0h03PgPk'
    delete_google_place_id 'Mülheimer Wikingerschiff - "MüWi"', 'ChIJZbOMyfXAuEcRdWcCU4J79Hs'
    delete_google_place_id 'ExtraSchicht – Die Nacht der Industriekultur 2014', 'ChIJhYwhvdENuUcR38d8F15Vn9k'
    delete_google_place_id 'Klavier-Festival Ruhr', 'ChIJzWe8tM3CuEcRA6lBkuOTfQM'
    delete_google_place_id 'SISTER ACT - Das Broadway Musical', 'ChIJmXcSs7DdsUcRHm6KZmysO50'
    delete_google_place_id 'outdoorcenter nrw/ Hochseilgarten Isselburg', 'ChIJQQtB6Ih9uEcRa_n_AzTTlzE'
    delete_google_place_id 'Personenschifffahrt Schmidt - MS Kemnade', 'ChIJjTnli1DYnUcRPnW_kFpqkRc'
  end

  def self.delete_google_place_id(name, place_id)
    update_google_place_id(name, from_place_id: place_id, to_place_id: nil)
  end

  def self.update_google_place_id(name, from_place_id:, to_place_id:)
    offer = Offer.find_by name: name, google_place_id: from_place_id
    fail "Offer with name #{name} and place id #{from_place_id} not found" unless offer.present?
    offer.update_attribute :google_place_id, to_place_id
  end
end
