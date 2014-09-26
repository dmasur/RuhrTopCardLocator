##
# Save a Offer from a offer parser
class ParseOffer
  extend Surrounded::Context

  initialize :offer_parser, :overview_parser, :offer

  def self.call(offer_parser, overview_parser, offer_link)
    offer = Offer.find_or_create_by(name: offer_parser.name)
    offer.url = offer_link
    new(offer_parser, overview_parser, offer).call
  end

  def call
    offer.update_attributes! offer_parser.as_attributes
    offer.update_attributes! overview_parser.as_attributes
    offer.update_attribute :year, 2014
    offer.save!
    offer
  end
  trigger :call

  role :overview_parser do
    def as_attributes
      {
        kind: kind
      }
    end
  end

  role :offer_parser do
    def as_attributes
      {
        google_place_id: google_place_id,
        street: street,
        city: city,
        website: website,
        category: category,
        description: description
      }
    end

    def google_place_client
      GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
    end

    def google_place_id
      google_place_client.spots_by_query("#{name}, #{city}").first.try(:place_id)
    end
  end
end
