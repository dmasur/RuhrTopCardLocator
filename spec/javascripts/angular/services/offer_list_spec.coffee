describe "RuhrTopCard Locator", () ->

  beforeEach module('ruhrTopCardLocator')
  beforeEach inject (ipCookie) ->
    ipCookie("alreadyVisted", [])

  window.google =
    maps:
      LatLng: ->
        'LatLng1'
      geometry:
        spherical:
          computeDistanceBetween: (latLng1, latLng2) ->
            1000

  it "definies OfferList", inject (OfferList) ->
    expect(OfferList).toBeDefined()

  describe "OfferList", () ->
    valid_offer_json = {
      id: 1
      name: "Test Offer"
      longitude: 10
      latitude: 20
      category: "Erlebnis, Spaß und Action"
      kind: "Eintritt frei"
      google_place_rating: 3
    }

    beforeEach inject (OfferList) ->
      @offer_list = new OfferList
      spyOn(@offer_list, 'refreshShownOffers')
      @offer_list.loadJson([valid_offer_json])

    it 'loads offers', ->
      expect(@offer_list.offers.length).toBe 1
      expect(@offer_list.offers[0].name).toBe "Test Offer"
      expect(@offer_list.refreshShownOffers).toHaveBeenCalled()

    describe 'refreshShownOffers', ->

      beforeEach inject (OfferList) ->
        @offer_list = new OfferList
        @offer_list.loadJson([valid_offer_json])

      it 'shows without changes', ->
        expect(@offer_list.shownOffers.length).toBe 1
        @offer_list.refreshShownOffers()
        expect(@offer_list.shownOffers.length).toBe 1

      it 'dont show with max distance', ->
        @offer_list.maxDistance = 1
        @offer_list.offers[0].distanceToUser = 2000
        expect(@offer_list.shownOffers.length).toBe 1
        @offer_list.refreshShownOffers()
        expect(@offer_list.shownOffers.length).toBe 0

      it 'dont show when category is not shown', ->
        @offer_list.showCategoryAction = false
        expect(@offer_list.shownOffers.length).toBe 1
        @offer_list.refreshShownOffers()
        expect(@offer_list.shownOffers.length).toBe 0

      it 'dont show when kind is not shown', ->
        @offer_list.showKindFree = false
        expect(@offer_list.shownOffers.length).toBe 1
        @offer_list.refreshShownOffers()
        expect(@offer_list.shownOffers.length).toBe 0

      it 'dont show when not visited are hidden', ->
        @offer_list.showNotVisited = false
        expect(@offer_list.shownOffers.length).toBe 1
        @offer_list.refreshShownOffers()
        expect(@offer_list.shownOffers.length).toBe 0
