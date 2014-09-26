##
# Save a Offer from a offer parser
class ParseOffer
  extend Surrounded::Context

  initialize :offer_parser, :overview_parser, :offer

  shortcut_triggers

  def call
    offer.attributes = offer_parser.as_attributes
    offer.kind = overview_parser.kind
    offer.year = 2014
    offer.save!
  end
  trigger :call

  role :overview_parser

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
