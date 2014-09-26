require './lib/site_parser'
namespace :seed do
  desc 'Seed and geocode Offers'
  task create_offers_from_website: :environment do
    SiteParser.parse_from_website

    Offer.all.each do |offer|
      next if offer.latitude && offer.longitude
      offer.geocode
      offer.save
    end

    SiteParser.fix_seeds
  end

end
