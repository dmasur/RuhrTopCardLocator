require 'spec_helper'
require './lib/offer_overview_parser'

describe OfferOverviewParser do
  let(:parser) do
    dir = File.dirname(__FILE__)
    offer_overview_path = "#{dir}/../data/www.ruhrtopcard.de/angebote_eintritt_frei/eintritt_frei.php.html"
    OfferOverviewParser.new File.read(offer_overview_path)
  end

  describe 'offer_links' do
    it 'has three links' do
      expect(parser.offer_links.size).to eq 95
    end
  end
end
