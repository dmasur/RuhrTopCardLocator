require './lib/site_parser'
require './lib/fix_google_infos'

namespace :seed do
  desc 'Seed and geocode Offers'
  task create_offers_from_website: :environment do
    #SiteParser.parse_from_website
    FixGoogleInfos.fix_all
    UpdateOffer.full_update_all
  end

  desc 'Test seeded offers'
  task test: :environment do
    client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
    Offer.all.each do |offer|
      puts '=' * 10
      puts offer.name
      if offer.google_place_id?
        spot = client.spot(offer.google_place_id)
        puts spot.name
        puts offer.google_place_id
        distance = offer.distance_to([spot.lat, spot.lng])
        if distance > 1
          puts "Distance from geocoding to Google Geocoords: #{distance}"
          puts "Original: #{offer.latitude}, #{offer.longitude} #{offer.street} #{offer.city}"
          puts "Google: #{spot.lat}, #{spot.lng} #{spot.formatted_address}"
        end
      else
        puts 'No Google Place ID'
      end
    end
  end
end
