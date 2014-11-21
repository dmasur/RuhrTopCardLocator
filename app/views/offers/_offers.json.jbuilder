json.array! Offer.where.not(name: nil) do |offer|
  json.partial! 'offers/offer.json', offer: offer
end
