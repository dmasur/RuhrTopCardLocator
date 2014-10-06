require 'rails_helper'

describe 'Offer Indexpage', type: :feature do
  it 'shows the offers' do
    create :offer, :grugapark
    visit '/'
    click_button 'Orte mich!'
    expect(page).to have_content('1 von 1 Angeboten werden angezeigt')
    expect(page).to have_content('0.66 km')
  end

  describe 'Sidebar' do
    it 'can be filtered with distance 15' do
      create :offer, :grugapark
      create :offer, :kernie
      visit '/'
      click_button 'Reset'
      click_button 'Orte mich!'
      expect(page).to have_content('0 km') # Wait for distance calc
      find('label', text: '15 km').click
      expect(page).to have_content('Grupapark')
      expect(page).to have_no_content('Kernie´s Familienpark im Wunderland Kalkar')
    end

    describe 'can be sorted' do
    end

    describe 'can be filtered for categories' do
      it 'hides action offers' do
        create :offer, :grugapark
        visit '/'
        find('label', text: 'Erlebnis, Spaß und Action').click
        expect(page).to have_content('0 von 1 Angeboten werden angezeigt')
      end
    end
  end

  describe 'Visited Filter' do
    it 'marks an offer as visited' do
      create :offer, :grugapark
      visit '/'
      click_button 'Reset'
      expect(page).to have_content('Grupapark')
      find('a.js-mark-as-vistied').click
      expect(page).to have_no_content('Grupapark')
    end

    it 'marks an offer as not visited' do
      create :offer, :grugapark
      visit '/'
      click_button 'Reset'
      wait_until_angular_ready
      expect(page).to have_content('Grupapark')
      find('a.js-mark-as-vistied').click
      expect(page).to have_no_content('Grupapark')
      find('label:not(.active)', text: 'Besuchte').click
      find('label.active', text: 'Unbesuchte').click
      expect(page).to have_content('Grupapark')
      find('a.js-mark-as-not-vistied').click
      expect(page).to have_no_content('Grupapark')
      find('label:not(.active)', text: 'Unbesuchte').click
      expect(page).to have_content('Grupapark')
    end
  end
end
