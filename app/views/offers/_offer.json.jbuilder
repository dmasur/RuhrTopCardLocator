json.extract! offer, :id, :name, :category, :kind, :description, :street, :city, :url

json.rating offer.google_place_rating

json.coords do
  json.latitude offer.latitude
  json.longitude offer.longitude
end

json.icon map_image_for(offer)