describe "RuhrTopCard Locator", () ->

  beforeEach module('ruhrTopCardLocator')

  window.google =
    maps:
      LatLng: ->
        'LatLng1'
      geometry:
        spherical:
          computeDistanceBetween: (latLng1, latLng2) ->
            1000


  describe "test", () ->
    valid_offer_json = {
      id: 1
      name: "Test Offer"
      longitude: 10
      latitude: 20
      category: "Erlebnis, Spaß und Action"
      kind: "Eintritt frei"
      google_place_rating: 3
    }

    it "definies Offer", inject (Offer) ->
      expect(Offer).toBeDefined()

    it "loads a free offer", inject (Offer) ->
      offer = new Offer(valid_offer_json)
      expect(offer.id).toBe(1)
      expect(offer.name).toBe('Test Offer')
      expect(offer.coords.longitude).toBe(10)
      expect(offer.coords.latitude).toBe(20)
      expect(offer.category).toBe("Erlebnis, Spaß und Action")
      expect(offer.kind).toBeNotDefined
      expect(offer.rating).toBe(3)

    it "calls google for a distance calc", inject (Offer) ->
      offer = new Offer(valid_offer_json)
      offer.latLng = 'LatLng' # TODO: Remove in favor of a good mock
      latLng = 'LatLng2'
      spyOn(google.maps.geometry.spherical, 'computeDistanceBetween')
      offer.distanceTo(latLng)
      expect(google.maps.geometry.spherical.computeDistanceBetween).toHaveBeenCalledWith 'LatLng', 'LatLng2'

    it "mark a visit and saves in cookie", inject (Offer, ipCookie) ->
      offer = new Offer(valid_offer_json)
      offer.markAsVisited()
      expect(offer.visited).toBe true
      expect(ipCookie("alreadyVisted").length).toBe 1
      expect(ipCookie("alreadyVisted")).toContain 1

    it "shows that an offer is in range", inject (Offer) ->
      offer = new Offer(valid_offer_json)
      offer.distanceToUser = 2000 # Meters
      maxDistance = 3 # Kilometers
      expect(offer.inRangeOf(maxDistance)).toBe(true)

    it "shows that an offer is not in range", inject (Offer) ->
      offer = new Offer(valid_offer_json)
      offer.distanceToUser = 2000 # Meters
      maxDistance = 1 # Kilometers
      expect(offer.inRangeOf(maxDistance)).toBe(false)