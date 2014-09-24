require 'spec_helper'
require './lib/offer_parser'

describe OfferParser do
  let(:parser) do
    dir = File.dirname(__FILE__)
    offer_path = "#{dir}/../data/www.ruhrtopcard.de/#{path}"
    OfferParser.new File.read(offer_path)
  end

  describe 'Aquarius' do
    let(:path) { 'angebote_eintritt_frei/erlebnis_industriekultur/aquarius_wassermuseum.php.html' }

    it 'has a name' do
      expect(parser.name).to eq 'Aquarius Wassermuseum'
    end

    it 'has a description' do
      expect(parser.description).to eq 'Multimediatechnik und herausragende Architektur machen den Rundgang durch den über 100 Jahre alten Wasserturm der RWW Rheinisch-Westfälische Wasserwerksgesellschaft zum faszinierenden Erlebnis. Starten Sie mit einer Chipkarte über 30 Computerstationen. Erfahren Sie Wissenswertes über Wassertürme, Kanäle und Talsperren! Lernen Sie u. a. die Themen Grund-, Trink- und Virtuelles Wasser besser kennen. Bereisen Sie am sprechenden Globus interessante Wasserwelten! Nehmen Sie an der Weltwasserkonferenz teil, um die Weichen für eine klima- und wasserfreundliche Zukunft zu stellen. Abschließend können Sie sich eine persönliche Urkunde mit Ihren gesammelten Punkten von Quiz und Spielen ausdrucken.'
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

  describe 'RevuePalast' do
    let(:path) { 'angebote_halber_preis/14_vorhang_auf_2013/revuepalast_ruhr.php.html' }
    it 'parses street right' do
      expect(parser.street).to eq 'Werner-Heisenberg-Straße 2–4'
    end
  end

  describe 'RevuePalast' do
    let(:path) { 'angebote_halber_preis/14_vorhang_auf_2013/naturbuehne_hohensyburg.php.html' }
    it 'parses street right' do
      expect(parser.street).to eq 'Syburger Dorfstraße 60'
    end
  end

  describe 'Mir' do
    let(:path) { 'angebote_halber_preis/14_vorhang_auf_2013/mir__musiktheater_im_revier_gmbh.php.html' }
    it 'parses street right' do
      expect(parser.street).to eq 'Kennedyplatz'
    end
  end

  describe 'X-Spot Paintball' do
    let(:path) { 'angebote_halber_preis/13_abenteuer_nrw_2013/x_spot_paintball.php.html' }
    it 'parses street right' do
      expect(parser.street).to eq 'Spielstätte: Prosperstraße 299–301'
    end
  end

  describe 'Weinerlebnisseminar - Genuss pur' do
    let(:path) { 'angebote_halber_preis/13_abenteuer_nrw_2013/weinerlebnisseminar.php.html' }
    it 'parses street right' do
      expect(parser.street).to eq 'Hölzerweg 5a'
    end
  end

  describe 'Tour de Ruhr – Dortmund, Phoenix aus der Asche' do
    let(:path) { 'angebote_halber_preis/13_abenteuer_nrw_2013/tour_de_ruhr.php.html' }
    xit 'parses street right' do
      expect(parser.street).to eq 'Emscherstraße 71 (Landschaftspark Duisburg-Nord)'
    end
  end

  describe 'Grugapark Essen' do
    let(:path) { 'angebote_eintritt_frei/erlebnis_spass_action/grugapark.php.html' }
    xit 'parses street right' do
      expect(parser.street).to eq 'Haupteingang: Alfredstraße/Norberstraße 2'
    end
  end

  describe 'Extraschicht' do
    let(:path) { 'angebote_halber_preis/14_vorhang_auf_2013/extraschicht__die_nacht_der_industriekultur.php.html' }

    it 'parses website right' do
      expect(parser.website).to eq 'www.extraschicht.de'
    end

    it 'parses street right' do
      expect(parser.street).to be nil
    end
  end
end