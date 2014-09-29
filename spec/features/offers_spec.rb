require 'rails_helper'

describe "OfferList", type: :feature do
  before do
    execute_script ""
  end

  xit 'shows the offers' do
    create :offer, :grugapark
    visit '/'
    click_button 'Orte mich!'
    expect(page).to have_content('1 von 1 Angeboten werden angezeigt')
    expect(page).to have_content('110 km')
  end

  describe 'can be filtered with distance 15' do
    before do
      create :offer, :grugapark
      create :offer, :kernie
    end

    xit 'shows the offers right with filter' do
      visit '/'
      expect(page).to have_content('0 km') # Wait for distance calc
      find('label', :text => '15 km').click
      expect(page).to have_content('Grupapark')
      expect(page).to have_no_content('Kernie´s Familienpark im Wunderland Kalkar')
    end
  end

  describe 'can be sorted' do
  end

  describe 'can be filtered for categories' do
    it 'hides action offers' do
      create :offer, :grugapark
      visit '/'
      find('label', :text => 'Erlebnis, Spaß und Action').click
      expect(page).to have_content('0 von 1 Angeboten werden angezeigt')
    end
  end
end
