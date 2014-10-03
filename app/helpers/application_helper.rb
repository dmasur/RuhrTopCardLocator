##
# Application Helper
module ApplicationHelper
  ##
  # Find right icon for an offer
  def map_image_for(offer)
    image_path case offer.kind
               when 'Eintritt frei'
                 case offer.category
                 when 'Erlebnis, Spaß und Action' then 'themepark.png'
                 when 'Schifffahrt und Bäder' then 'swimming.png'
                 when 'Erlebnis Industriekultur' then 'museum_industry.png'
                 when 'Schätze und Museen' then 'art-museum-2.png'
                 else 'themepark.png'
                 end
               when 'Halber Preis' then 'symbol_euro.png'
               else 'star-3.png'
               end
  end
end
