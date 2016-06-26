require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

##
# Update an Offer with Google infos
class UpdateOffer
  extend Surrounded::Context

  initialize :offer

  ##
  # Update all offers with full infos
  def self.full_update_all
    Logger.new(STDOUT).info 'Full google update for all offers'
    ::Offer.all.each do |offer|
      UpdateOffer.full(offer)
    end
  end

  shortcut_triggers

  ##
  # Update all infos
  def full
    offer.update_infos
    offer.update_rating
    offer.save!
  end
  trigger :full

  ##
  # Only update the rating
  def rating
    offer.update_rating
    offer.save!
  end
  trigger :rating

  ##
  # Only set the place id
  def place_id
    offer.update_place_id
    offer.save!
  end
  trigger :place_id

  role :offer do
    def update_infos
      return unless google_place
      self.attributes = {
        google_place_id: google_place.place_id,
        latitude: google_place.lat,
        longitude: google_place.lng,
        street: [google_place.street, google_place.street_number].join(' '),
        city: [google_place.postal_code, google_place.city].join(' ')
      }
    end

    def update_rating
      return unless google_place
      self.google_place_rating = google_place.rating
    end

    def update_place_id
      return unless google_place
      self.google_place_id = google_place.place_id
    end

    ##
    # Use only name to find places. Worse results when combined with city
    def google_place
      if google_place_id
        @google_place ||= GooglePlaces::Client.new(ENV['GOOGLE_API_KEY']).spot(google_place_id)
      else
        begin
          @google_place ||= GooglePlaces::Client.new(ENV['GOOGLE_API_KEY']).spots_by_query(name).first
        rescue
        end
      end
        debugger
    end
  end
end
