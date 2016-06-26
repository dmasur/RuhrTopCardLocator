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
    #update_google_place_id 'Stiftung Eisenbahnmuseum Bochum',
    #                       from_place_id: 'ChIJiyaePdHduEcRLGmYi3cJDrE', to_place_id: 'ChIJe3p0rnneuEcRz0-4sWgxIOA'
    #update_google_place_id 'Up & Away - Outdoor und mehr ... Klettern leicht gemacht für Einsteiger',
    #                       from_place_id: 'ChIJheZGWG9MDhMRtyBMc7wV9Jg', to_place_id: 'ChIJ6y8dFNbwuEcRoXHLIxjIyBM'
  end

  ##
  # There are not places for this locations
  def delete_google_place_ids
    #delete_google_place_id 'alpincenter Klettergarten', 'ChIJfaFQndbMd0cRmFzoLLh73_I'
    #delete_google_place_id 'alpincenter Sommerrodelbahn', 'ChIJW0l_ZvjquEcRhXQrhlbk69M'
    #delete_google_place_id 'Kluterthöhle', 'ChIJ2TP7Pp0luUcRNpmLqOel8l4'
    #delete_google_place_id 'RVR NaturForum Bislicher Insel', 'ChIJx_85OhLquEcR19svu8S_kr8'
    #delete_google_place_id '15. ExtraSchicht – Die Nacht der Industriekultur', 'ChIJhYwhvdENuUcR38d8F15Vn9k'
    #delete_google_place_id 'Klavier-Festival Ruhr', 'ChIJQbNehjDduEcR4HhU9ECj1sI'
    #delete_google_place_id 'Domschatz Essen', 'ChIJC_pACzjbuEcRI7RebqbPnNo'
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
