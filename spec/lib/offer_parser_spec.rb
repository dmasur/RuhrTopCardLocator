require 'spec_helper'
require './lib/offer_parser'

describe OfferParser do
  let(:parser) do
    dir = File.dirname(__FILE__)
    offer_path = "#{dir}/../data/www.ruhrtopcard.de/#{path}"
    OfferParser.new File.read(offer_path)
  end

  describe 'Aquarius' do
    let(:path) { 'leistungen/eintritt-frei-2016/aquarius-wassermuseum/index.html' }

    it 'has a name' do
      expect(parser.name).to eq 'Aquarius Wassermuseum'
    end

    it 'has a description' do
      expect(parser.description).to eq 'Multimediatechnik und herausragende Architektur machen den Rundgang durch den über 100 Jahre alten Wasserturm der RWW Rheinisch-Westfälischen Wasserwerksgesellschaft zum faszinierenden Erlebnis. Starten Sie mit einer Chipkarte über 30 Computerstationen. Erfahren Sie Wissenswertes über Wassertürme, Kanäle und Talsperren! Lernen Sie u. a. die Themen Grund-, Trink- und Virtuelles Wasser besser kennen. Bereisen Sie am sprechenden Globus interessante Wasserwelten! Nehmen Sie an der Weltwasserkonferenz teil, um die Weichen für eine klima- und wasserfreundliche Zukunft zu stellen. Abschließend können Sie sich eine persönliche Urkunde mit Ihren gesammelten Punkten von Quiz und Spielen ausdrucken.'
    end

    it 'has an street' do
      expect(parser.street).to eq 'Burgstraße 70'
    end

    it 'has a city' do
      expect(parser.city).to eq '45476 Mülheim an der Ruhr'
    end

    it 'has a website' do
      expect(parser.website).to eq 'www.aquarius-wassermuseum.de'
    end

    it 'has a category' do
      expect(parser.category).to eq 'Erlebnis Industriekultur'
    end
  end

  describe 'Zoo Duisburg' do
    let(:path) { 'leistungen/eintritt-frei-2016/zoo-duisburg/index.html' }
    it 'parses name right' do
      expect(parser.name).to eq 'Zoo Duisburg'
    end
  end

  describe 'RevuePalast' do
    let(:path) { 'leistungen/halber-preis-2016/revuepalast-ruhr/index.html' }
    it 'parses street right' do
      expect(parser.street).to eq 'Werner-Heisenberg-Straße 2–4'
    end
  end

  describe 'Naturbühne Hohensyburg' do
    let(:path) { 'leistungen/halber-preis-2016/naturbuehne-hohensyburg-ev/index.html' }
    it 'parses street right' do
      expect(parser.street).to eq 'Syburger Dorfstraße 60'
    end
  end

  describe 'Mir' do
    let(:path) { 'leistungen/halber-preis-2016/mir-musiktheater-im-revier-gmbh/index.html' }
    it 'parses street right' do
      expect(parser.street).to eq 'Kennedyplatz'
    end
  end

  describe 'X-Spot Paintball' do
    let(:path) { 'leistungen/halber-preis-2016/x-spot-paintball/index.html' }
    it 'parses street right' do
      expect(parser.street).to eq 'Prosperstraße 299–301'
    end
  end

  describe 'Weinerlebnisseminar - Genuss pur' do
    let(:path) { 'leistungen/halber-preis-2016/weinerlebnisseminar-genuss-pur/index.html' }
    it 'parses street right' do
      expect(parser.street).to eq 'Hölzerweg 5a'
    end
  end

  describe 'Legoland Discovery Centre' do
    let(:path) { 'leistungen/eintritt-frei-2016/legoland-discovery-centre/index.html' }
    xit 'parses description right' do
      expect(parser.description).to be_present
    end
  end

  describe 'Tour de Ruhr – Dortmund, Phoenix aus der Asche' do
    let(:path) { 'leistungen/halber-preis-2016/tour-de-ruhr-radeln-zwischen-gasometer-und-huettenwerk/index.html' }
    it 'parses street right' do
      expect(parser.street).to eq 'Landschaftspark Duisburg-Nord'
    end
  end

  describe 'Grugapark Essen' do
    let(:path) { 'leistungen/eintritt-frei-2016/grugapark-essen/index.html' }
    it 'parses street right' do
      expect(parser.street).to eq 'Alfredstraße/Norbertstraße 2'
    end
  end

  describe 'Extraschicht' do
    let(:path) { 'leistungen/halber-preis-2016/16-extraschicht-die-nacht-der-industriekultur/index.html' }

    it 'parses website right' do
      expect(parser.website).to eq 'www.extraschicht.de'
    end

    it 'parses street right' do
      expect(parser.street).to be nil
    end
  end
end
