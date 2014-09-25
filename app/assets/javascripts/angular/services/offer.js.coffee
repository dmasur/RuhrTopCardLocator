angular.module('ruhrTopCardLocator').factory 'Offer', ['ipCookie', '$modal', (ipCookie, $modal) ->
  class Offer
    constructor: (offer_json) ->
      @id = offer_json.id
      @name = offer_json.name
      @coords = { latitude: offer_json.latitude, longitude: offer_json.longitude }
      @latLng = new google.maps.LatLng @coords.latitude, @coords.longitude
      @distanceToUser = null
      @visited = _.contains ipCookie("alreadyVisted"), @id

    # Calculate distance to another location
    distanceTo: (otherLatLng) ->
      return unless otherLatLng?
      window.google.maps.geometry.spherical.computeDistanceBetween(@latLng, otherLatLng)

    # Calculate and save distance to user
    refreshDistanceToUser: (userLatLng) ->
      @distanceToUser = @.distanceTo(userLatLng)

    visited: ->
      alreadyVisted = ipCookie("alreadyVisted")
      alreadyVisted.push(offer.id)
      ipCookie("alreadyVisted", alreadyVisted, expires: 365)
      @visited = true

    openInfo: ->
      modalInstance = $modal.open
        templateUrl: "offers/#{@id}"

    inRangeOf: (maxDistance) ->
      return true unless maxDistance?
      @distanceToUser <= maxDistance * 1000
]