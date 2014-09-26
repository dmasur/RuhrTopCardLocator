require 'rails_helper'
require './lib/offer_parser'
require './lib/offer_overview_parser'

describe ParseOffer do
  let(:offer_overview_parser) do
    dir = File.dirname(__FILE__)
    offer_overview_path = "#{dir}/../data/www.ruhrtopcard.de/angebote_eintritt_frei/eintritt_frei.php.html"
    OfferOverviewParser.new File.read(offer_overview_path)
  end

  let(:offer_parser) do
    dir = File.dirname(__FILE__)
    path = 'angebote_eintritt_frei/erlebnis_industriekultur/aquarius_wassermuseum.php.html'
    offer_path = "#{dir}/../data/www.ruhrtopcard.de/#{path}"
    OfferParser.new File.read(offer_path)
  end

  let(:offer) do
    Offer.new name: 'Aquarius Wassermuseum'
  end

  it 'sets attributes' do
    described_class.call(offer_parser, offer_overview_parser, offer)
    expect(offer.name).to eq 'Aquarius Wassermuseum'
    expect(offer.description).to eq 'Multimediatechnik und herausragende Architektur machen den Rundgang durch den '\
    'über 100 Jahre alten Wasserturm der RWW Rheinisch-Westfälische Wasserwerksgesellschaft zum faszinierenden '\
    'Erlebnis. Starten Sie mit einer Chipkarte über 30 Computerstationen. Erfahren Sie Wissenswertes über '\
    'Wassertürme, Kanäle und Talsperren! Lernen Sie u. a. die Themen Grund-, Trink- und Virtuelles Wasser besser '\
    'kennen. Bereisen Sie am sprechenden Globus interessante Wasserwelten! Nehmen Sie an der Weltwasserkonferenz '\
    'teil, um die Weichen für eine klima- und wasserfreundliche Zukunft zu stellen. Abschließend können Sie sich '\
    'eine persönliche Urkunde mit Ihren gesammelten Punkten von Quiz und Spielen ausdrucken.'
    expect(offer.street).to eq 'Burgstraße 70'
    expect(offer.city).to eq '45476 Mülheim an der Ruhr'
    expect(offer.website).to eq 'www.aquarius-wassermuseum.de'
    expect(offer.category).to eq 'Erlebnis Industriekultur'
  end

  it 'geocode offer' do
    described_class.call(offer_parser, offer_overview_parser, offer)
    expect(offer.latitude).to eq 51.4430897
    expect(offer.longitude).to eq 6.8559475
  end
end
