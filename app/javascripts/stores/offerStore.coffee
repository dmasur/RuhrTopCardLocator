Fluxxor = require 'fluxxor'
jquery = require 'jquery'
Leaflet = require 'leaflet'

module.exports = Fluxxor.createStore
  mergeFilter: (new_filters) ->
    # console.log 'merge', @filters, new_filters
    @filters = jquery.extend @filters, new_filters
    # console.log "Set Kind Free State to #{@filters.kinds.free}"
    @.emit("change")

  setPosition: (position) ->
    latLng = new Leaflet.LatLng(position.coords.latitude, position.coords.longitude)
    jquery.each @offers, (index, offer) ->
      offer.distance = latLng.distanceTo(offer.latLng)
      rounded_distance =  Math.round(offer.distance / 10) / 100
      offer.distanceString = "#{rounded_distance} km"
    @.emit("change")

  setOffers: (offers) ->
    @offers = offers
    jquery.each @offers, (index, offer) ->
      offer.latLng = new Leaflet.LatLng(offer.coords.latitude, offer.coords.longitude)

  actions:
    MERGE_FILTER: 'mergeFilter'
    SET_POSITION: 'setPosition'
    SET_OFFERS: 'setOffers'

  getShownOffers: ->
    @offers.filter (offer) =>
      showOffer = !@filters.kinds[offer.kind]
      showOffer

  initialize: ->
    @reset()
    @offers = []
    this

  reset: ->
    @position = null
    @filters =
      kinds:
        free: false
        halfPrice: false
        special: false

  getKinds: ->
    @filters.kinds