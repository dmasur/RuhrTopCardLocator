json.array! Offer.all do |offer|
  json.id offer.id
  json.name offer.name
  json.longitude offer.longitude
  json.latitude offer.latitude
  json.category offer.category
  json.kind offer.kind
  json.longitude offer.longitude
  json.google_place_rating offer.google_place_rating
  json.icon map_image_for(offer)
end