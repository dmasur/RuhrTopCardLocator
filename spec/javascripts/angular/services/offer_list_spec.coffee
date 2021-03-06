describe "RuhrTopCard Locator", () ->

  beforeEach module('ruhrTopCardLocator')
  beforeEach inject ($localStorage) ->
    $localStorage.$reset()

  it "definies OfferList", inject (OfferList) ->
    expect(OfferList).toBeDefined()

  describe "OfferList", () ->
    valid_offer_json = {
      id: 1
      name: "Test Offer"
      coords:
        longitude: 10
        latitude: 20
      category: "Erlebnis, Spaß und Action"
      kind: "Eintritt frei"
      google_place_rating: 3
    }

    beforeEach inject (OfferList) ->
      @offer_list = new OfferList()
      @offer_list.loadJson([valid_offer_json])

    it 'loads offers', ->
      expect(@offer_list.offers.length).toBe 1
      expect(@offer_list.offers[0].name).toBe "Test Offer"

    describe 'save state to cookie', ->
      it 'saves max Distance', inject ($localStorage) ->
        expect($localStorage.maxDistance).toBe undefined
        @offer_list.storage.maxDistance = 1
        expect($localStorage.maxDistance).toBe 1

    describe 'refreshShownOffers', ->
      beforeEach inject (OfferList) ->
        @offer_list = new OfferList()
        @offer_list.loadJson([valid_offer_json])
        @offer_list.refreshShownOffers()

      it 'refreshes without changes', ->
        expect(@offer_list.shownOffers().length).toBe 1
        @offer_list.refreshShownOffers()
        expect(@offer_list.shownOffers().length).toBe 1

      it 'dont show with max distance', ->
        @offer_list.storage.maxDistance = 1
        @offer_list.offers[0].distanceToUser = 2000
        expect(@offer_list.shownOffers().length).toBe 1
        @offer_list.refreshShownOffers()
        expect(@offer_list.shownOffers().length).toBe 0

      it 'dont show when category is not shown', ->
        @offer_list.storage.showCategoryAction = false
        expect(@offer_list.shownOffers().length).toBe 1
        @offer_list.refreshShownOffers()
        expect(@offer_list.shownOffers().length).toBe 0

      it 'dont show when kind is not shown', ->
        @offer_list.storage.showKindFree = false
        expect(@offer_list.shownOffers().length).toBe 1
        @offer_list.refreshShownOffers()
        expect(@offer_list.shownOffers().length).toBe 0

      it 'dont show when not visited are hidden', ->
        @offer_list.storage.showNotVisited = false
        expect(@offer_list.shownOffers().length).toBe 1
        @offer_list.refreshShownOffers()
        expect(@offer_list.shownOffers().length).toBe 0
