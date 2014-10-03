json.array! Offer.all do |offer|
  json.partial! 'offers/offer.json', offer: offer
end
