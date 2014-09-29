require 'rails_helper'

describe "OfferList", type: :feature, vcr: true do
  it 'shows the offers' do
    create :offer, :grugapark
    visit '/'
    expect(page).to have_content('1 von 1 Angeboten werden angezeigt')
  end

  describe 'can be filtered with distance 15' do
    it 'shows an offer in distance of 10'
    it 'doesnt show an offer in distance of 20'
  end

  describe 'can be sorted' do
  end

  describe 'can be filtered for categories' do
    it 'hides action offers' do
      visit '/'
      Capybara::Screenshot.autosave_on_failure = true
    end
  end
end
