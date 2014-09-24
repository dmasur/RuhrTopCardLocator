require 'spec_helper'
require './lib/homepage_parser'

describe HomepageParser do
  let(:parser) do
    dir = File.dirname(__FILE__)
    index_path = "#{dir}/../data/www.ruhrtopcard.de/index.html"
    HomepageParser.new File.read index_path
  end

  describe 'offer_overview_links' do
    it 'returns only links' do
      parser.offer_overview_links.each do |link|
        expect(link).to be_a String
      end
    end

    it 'has three links' do
      expect(parser.offer_overview_links.size).to eq 3
    end

    it 'returns angebot links' do
      parser.offer_overview_links.each do |link|
        expect(link.to_s).to include 'angebot'
      end
    end
  end
end