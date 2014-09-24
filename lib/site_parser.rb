require 'homepage_parser'
require 'offer_overview_parser'
require 'offer_parser'
require 'mechanize'

class SiteParser
  def self.parse_from_website
    agent = Mechanize.new
    page = agent.get('http://www.ruhrtopcard.de')
    homepage_parser = HomepageParser.new(page.body)
    homepage_parser.offer_overview_links.each do |offer_overview_link|
      OfferOverviewParser.new(agent.get(offer_overview_link).body).offer_links.each do |offer_link|
        offer_parser = OfferParser.new(agent.get(offer_link).body)
        ParseOffer.call(offer_parser)
      end
    end
  end

  def self.parse_from_data
    root_path = "./spec/data/www.ruhrtopcard.de/"
    Dir.foreach(root_path) do |kind_path|
      full_kind_path = root_path + kind_path + '/'
      next unless is_valid_dir? full_kind_path
      Dir.foreach(full_kind_path) do |category_path|
        full_category_path = full_kind_path + category_path + '/'
        next unless is_valid_dir? full_category_path
        Dir.foreach(full_category_path) do |offer_path|
          full_offer_path = full_category_path + offer_path
          next if full_offer_path.ends_with?('.')
          offer_parser = OfferParser.new(File.read full_offer_path)
          ParseOffer.call(offer_parser)
        end
      end
    end
  end

  def self.is_valid_dir?(path)
    !path.ends_with?('./') && File.directory?(path)
  end
end