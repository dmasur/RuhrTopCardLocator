Fluxxor = require 'fluxxor'
jquery = require 'jquery'
Leaflet = require 'leaflet'

module.exports = Fluxxor.createStore
  mergeFilter: (new_filters) ->
    @filters = jquery.extend @filters, new_filters
    @emit("change")

  setPosition: (position) ->
    latLng = new Leaflet.LatLng(position.coords.latitude, position.coords.longitude)
    jquery.each @offers, (index, offer) ->
      offer.distance = latLng.distanceTo(offer.latLng)
      rounded_distance =  Math.round(offer.distance / 10) / 100
      offer.distanceString = "#{rounded_distance} km"
    @emit("change")

  setOffers: (offers) ->
    @offers = offers
    jquery.each @offers, (index, offer) ->
      offer.latLng = new Leaflet.LatLng(offer.coords.latitude, offer.coords.longitude)
      offer.visited = false

  toggleOfferVisit: (offer) ->
    offer.visited = !offer.visited
    @emit("change")

  actions:
    MERGE_FILTER: 'mergeFilter'
    SET_POSITION: 'setPosition'
    TOGGLE_OFFER_VISIT: 'toggleOfferVisit'

  getShownOffers: ->
    @offers.filter (offer) =>
      showOffer = !@filters.kindFilter[offer.kind]
      showOffer &&= !@filters.categoryFilter[offer.category] if offer.kind == 'free'
      showOffer &&= !@filters.visitFilter.visited if offer.visited
      showOffer &&= !@filters.visitFilter.unvisited unless offer.visited
      showOffer

  initialize: ->
    @reset()
    @offers = []
    this

  reset: ->
    @position = null
    @filters =
      kindFilter:
        free: false
        halfPrice: false
        special: false
      categoryFilter:
        action: false
        water: false
        industry: false
        museeum: false
      visitFilter:
        visited: true
        unvisited: false

  getkindFilter: ->
    @filters.kindFilter

  getcategoryFilter: ->
    @filters.categoryFilter

  getVisitFilter: ->
    @filters.visitFilter
