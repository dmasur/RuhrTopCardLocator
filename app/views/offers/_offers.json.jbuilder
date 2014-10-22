json.array! Offer.all.limit(1) do |offer|
  json.partial! 'offers/offer.json', offer: offer
end
