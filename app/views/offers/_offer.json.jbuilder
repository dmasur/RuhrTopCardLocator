json.extract! offer, :id, :name, :category, :description, :street, :city, :url

json.kind case offer.kind
          when 'Eintritt frei' then 'free'
          when 'Halber Preis' then 'halfPrice'
          when 'Spezial' then 'special'
          else offer.kind
          end

json.rating offer.google_place_rating

json.coords do
  json.latitude offer.latitude
  json.longitude offer.longitude
end

json.icon map_image_for(offer)
