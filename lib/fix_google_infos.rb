##
# Fix Offers that are not properly parsed from the website
class FixGoogleInfos
  # Shortcut
  def self.fix_all
    new.fix_all
  end

  ##
  # Update and delete google places
  def fix_all
    delete_google_place_ids
    update_google_place_ids
  end

  private

  ##
  # Update the place id to proper location
  def update_google_place_ids
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
                           from_place_id: 'ChIJheZGWG9MDhMRtyBMc7wV9Jg', to_place_id: 'ChIJ6y8dFNbwuEcRoXHLIxjIyBM'
  end

  ##
  # There are not places for this locations
  def delete_google_place_ids
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

  ##
  # Deletes place id from offer
  def delete_google_place_id(name, place_id)
    update_google_place_id(name, from_place_id: place_id, to_place_id: nil)
  end

  ##
  # Updates a place id of a offer
  # Ensure that the old location is there if the seeding from the website changed
  def update_google_place_id(name, from_place_id:, to_place_id:)
    offer = Offer.find_by name: name, google_place_id: from_place_id
    fail "Offer with name #{name} and place id #{from_place_id} not found" unless offer.present?
    offer.update_attribute :google_place_id, to_place_id
  end
end
