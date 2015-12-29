##
# Save a Offer from a offer parser
class ParseOffer
  extend Surrounded::Context

  initialize :offer_parser, :offer

  shortcut_triggers

  # Update offer from parsing
  def call
    offer.attributes = offer_parser.as_attributes
    offer.kind = offer_parser.kind
    offer.year = Date.today.year
    offer.save!
  end
  trigger :call

  role :offer

  role :offer_parser do
    def as_attributes
      {
        street: street,
        city: city,
        website: website,
        category: category,
        description: description
      }
    end
  end
end
