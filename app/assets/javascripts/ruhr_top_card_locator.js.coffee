ruhrTopCardLocator = angular.module('ruhrTopCardLocator', ['google-maps', 'geolocation', 'ui.bootstrap']);

class Offer
  constructor: (offer, userLatLng) ->
    @name = offer.name
    @coords = { latitude: offer.latitude, longitude: offer.longitude }
    @latLng = new google.maps.LatLng offer.latitude, offer.longitude
    @id = offer.id
    @distanceToUser = @.distanceTo(userLatLng)
    @show_description = false

  # Calculate distance to another location
  distanceTo: (latLng2) ->
    return unless latLng2?
    window.google.maps.geometry.spherical.computeDistanceBetween(@latLng, latLng2)

  # Calculate and save distance to user
  refreshDistanceToUser: (userLatLng) ->
    @distanceToUser = @.distanceTo(userLatLng)

  # Toggle display of the description
  toggleDescription: ->
    $(event.target).toggleClass('fa-caret-right fa-caret-down')
    @show_description = !@show_description

ruhrTopCardLocator.controller 'MapController', ['$scope', 'geolocation', '$modal', ($scope, geolocation, $modal) ->
  $scope.userLatLng = $scope.userCoords = null
  $scope.sorting = 'name'
  $scope.distance = null
  $scope.shownOffers = []

  # Fetch user geo coordinates
  geolocation.getLocation().then (data) ->
    $scope.userCoords = { latitude: data.coords.latitude, longitude: data.coords.longitude }
    $scope.userLatLng = new google.maps.LatLng(data.coords.latitude, data.coords.longitude)
    $scope.map.center = $scope.userCoords
    $.each $scope.offers, (index, offer) ->
      offer.refreshDistanceToUser($scope.userLatLng)
    $scope.refreshShownOffers()

  # Init with all offers
  $scope.createOffers = (offers_json) ->
    $scope.offers = $.map offers_json, (offer) ->
      new Offer(offer, $scope.userLatLng)
    $scope.refreshShownOffers()

  # All offers that are shown
  $scope.refreshShownOffers = ->
    $scope.shownOffers = _.filter $scope.offers, (offer) ->
      if $scope.distance?
        offer.distanceToUser <= $scope.distance * 1000
      else
        true

  # Map defaults
  $scope.map = {
    center: { latitude: 51.4296308, longitude: 7.0039007 },
    zoom: 11
  }

  $scope.openInfo = (offerId) ->
    modalInstance = $modal.open
      templateUrl: "offers/#{offerId}"
]