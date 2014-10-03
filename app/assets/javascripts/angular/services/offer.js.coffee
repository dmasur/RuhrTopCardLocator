angular.module('ruhrTopCardLocator').factory 'Offer', ['$localStorage', '$modal', ($localStorage, $modal) ->
  class Offer
    constructor: (offer_json) ->
      $.extend this, offer_json
      @kind = @chooseKind(offer_json.kind)
      @category = offer_json.category unless @kind
      @latLng = new L.LatLng @coords.latitude, @coords.longitude
      @distanceToUser = null
      @visited = _.contains $localStorage.alreadyVisted, @id
      @icon = new L.icon
      @icon.iconUrl = offer_json.icon


    # Calculate distance to another location
    distanceTo: (otherLatLng) ->
      return unless otherLatLng?
      @latLng.distanceTo(otherLatLng)

    # Calculate and save distance to user
    refreshDistanceToUser: (userLatLng) ->
      @distanceToUser = @.distanceTo(userLatLng)

    # Save the info in a cookie
    markAsVisited: ->
      alreadyVisted = $localStorage.alreadyVisted or []
      alreadyVisted.push(@id)
      $localStorage.alreadyVisted = _.uniq(alreadyVisted)
      @visited = true

    # Save the info in a cookie
    markAsNotVisited: ->
      alreadyVisted = $localStorage.alreadyVisted or []
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
      return 'half-price' if kind is 'Halber Preis'
      return 'special' if $.contains(kind, 'Special')
]