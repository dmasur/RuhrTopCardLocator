json.extract! offer, :id, :name, :category, :description, :street, :city, :url

json.kind case offer.kind
          when 'Eintritt frei' then 'free'
          when 'Halber Preis' then 'halfPrice'
          when 'Spezial' then 'special'
          else offer.kind
          end
json.categoryName offer.category

json.category case offer.category
              when 'Erlebnis, Spaß und Action' then 'action'
              when 'Schifffahrt und Bäder' then 'water'
              when 'Erlebnis Industriekultur' then 'industry'
              when 'Schätze und Museen' then 'museeum'
              when 'Halber Preis' then 'halfPrice'
              else offer.category
              end
              
json.rating offer.google_place_rating

json.coords do
  json.latitude offer.latitude
  json.longitude offer.longitude
end

json.icon map_image_for(offer)
