ruhrTopCardLocator = angular.module('ruhrTopCardLocator', ['google-maps', 'geolocation', 'ui.bootstrap', 'ipCookie']);

ruhrTopCardLocator.factory 'UserLocation', ['geolocation', (geolocation) ->
  class UserLocation
    constructor: ->
      @coords = @latLng = null

    locateUser: (callback) ->
      geolocation.getLocation().then (data) ->
        @coords = { latitude: data.coords.latitude, longitude: data.coords.longitude }
        @latLng = new google.maps.LatLng(data.coords.latitude, data.coords.longitude)
        callback(@latLng)
]

ruhrTopCardLocator.factory 'OfferList', ['ipCookie', (ipCookie) ->
  class OfferList
    constructor: ->
      @shownOffers = @offers = []
      @sortOrder = 'name'
      @maxDistance = null

    loadJson: (json) ->
      @offers = $.map json, (offer) ->
        visited = _.contains ipCookie("alreadyVisted"), offer.id
        new Offer(offer, null, visited)
      @refreshShownOffers()

    # All offers that are shown
    refreshShownOffers: ->
      @shownOffers = _.filter @offers, (offer) ->
        show = if @maxDistance?
          offer.distanceToUser <= @maxDistance * 1000
        else
          true
        show && !offer.visited
]

ruhrTopCardLocator.controller 'MapController', ['$scope', 'geolocation', '$modal', 'ipCookie', 'UserLocation', 'OfferList', ($scope, geolocation, $modal, ipCookie, UserLocation, OfferList) ->
  ipCookie('year', 2014, expires: 365)
  ipCookie("alreadyVisted") || ipCookie("alreadyVisted", [])

  $scope.offerList = new OfferList

  $scope.userLocation = new UserLocation
  $scope.userLocation.locateUser (userLatLng) ->
    $.each $scope.offerList.offers, (index, offer) ->
      offer.refreshDistanceToUser(userLatLng)

  $scope.visitedOffer = (offer) ->
    $(event.target).parents('tr').remove()
    alreadyVisted = ipCookie("alreadyVisted")
    alreadyVisted.push(offer.id)
    ipCookie("alreadyVisted", alreadyVisted, expires: 365)
    offer.visited = true
    $scope.refreshShownOffers()


  # Map defaults
  $scope.map = {
    center: { latitude: 51.4296308, longitude: 7.0039007 },
    zoom: 11
  }

  $scope.openInfo = (offerId) ->
    modalInstance = $modal.open
      templateUrl: "offers/#{offerId}"
]