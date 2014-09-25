ruhrTopCardLocator = angular.module('ruhrTopCardLocator', ['google-maps', 'geolocation', 'ui.bootstrap', 'ipCookie']);

ruhrTopCardLocator.factory 'UserLocation', ['geolocation', (geolocation) ->
  class UserLocation
    constructor: ->
      @coords = null
      @latLng = null

    locateUser: (callback) ->
      geolocation.getLocation().then (data) ->
        @coords = { latitude: data.coords.latitude, longitude: data.coords.longitude }
        @latLng = new google.maps.LatLng(data.coords.latitude, data.coords.longitude)
        callback(@latLng)
]



ruhrTopCardLocator.controller 'MapController', ['$scope', 'geolocation', '$modal', 'ipCookie', 'UserLocation', ($scope, geolocation, $modal, ipCookie, UserLocation) ->
  $scope.sorting = 'name'
  $scope.distance = null
  $scope.shownOffers = []
  ipCookie('year', 2014, expires: 365)
  ipCookie("alreadyVisted") || ipCookie("alreadyVisted", [])

  $scope.userLocation = new UserLocation
  $scope.userLocation.locateUser (userLatLng) ->
    $.each $scope.offers, (index, offer) ->
      offer.refreshDistanceToUser(userLatLng)
    $scope.refreshShownOffers()

  # Init with all offers
  $scope.createOffers = (offers_json) ->
    $scope.offers = $.map offers_json, (offer) ->
      visited = _.contains ipCookie("alreadyVisted"), offer.id
      new Offer(offer, $scope.userLatLng, visited)
    $scope.refreshShownOffers()

  $scope.visitedOffer = (offer) ->
    $(event.target).parents('tr').remove()
    alreadyVisted = ipCookie("alreadyVisted")
    alreadyVisted.push(offer.id)
    ipCookie("alreadyVisted", alreadyVisted, expires: 365)
    offer.visited = true
    $scope.refreshShownOffers()

  # All offers that are shown
  $scope.refreshShownOffers = ->
    $scope.shownOffers = _.filter $scope.offers, (offer) ->
      show = if $scope.distance?
        offer.distanceToUser <= $scope.distance * 1000
      else
        true
      show && !offer.visited

  # Map defaults
  $scope.map = {
    center: { latitude: 51.4296308, longitude: 7.0039007 },
    zoom: 11
  }

  $scope.openInfo = (offerId) ->
    modalInstance = $modal.open
      templateUrl: "offers/#{offerId}"
]