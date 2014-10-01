angular.module('ruhrTopCardLocator').factory 'Offer', ['$localStorage', '$modal', ($localStorage, $modal) ->
  class Offer
    constructor: (offer_json) ->
      $.extend this, offer_json
      @kind = @chooseKind(offer_json.kind)
      @category = offer_json.category unless @kind
      @latLng = new google.maps.LatLng @coords.latitude, @coords.longitude
      @distanceToUser = null
      @visited = _.contains $localStorage.alreadyVisted, @id

    # Calculate distance to another location
    distanceTo: (otherLatLng) ->
      return unless otherLatLng?
      window.google.maps.geometry.spherical.computeDistanceBetween(@latLng, otherLatLng)

    # Calculate and save distance to user
    refreshDistanceToUser: (userLatLng) ->
      @distanceToUser = @.distanceTo(userLatLng)

    # Save the info in a cookie
    markAsVisited: ->
      alreadyVisted = $localStorage.alreadyVisted || []
      alreadyVisted.push(@id)
      $localStorage.alreadyVisted = _.uniq(alreadyVisted)
      @visited = true

    # Save the info in a cookie
    markAsNotVisited: ->
      alreadyVisted = $localStorage.alreadyVisted || []
      $localStorage.alreadyVisted = _.without(alreadyVisted, @id)
      @visited = false

    # opens the modal with more infos
    openInfo: ->
      modalInstance = $modal.open
        templateUrl: "offers/#{@id}"

    inRangeOf: (maxDistance) ->
      return true unless maxDistance?
      @distanceToUser <= maxDistance * 1000

    chooseKind: (kind) ->
      return 'half-price' if kind == 'Halber Preis'
      return 'special' if kind.contains 'Special'
]