ruhrTopCardLocator = angular.module('ruhrTopCardLocator', ['google-maps', 'geolocation', 'ui.bootstrap', 'ipCookie'])

ruhrTopCardLocator.controller 'OffersController',
['$scope', 'ipCookie', 'UserLocation', 'OfferList', ($scope, ipCookie, UserLocation, OfferList) ->

  # Set Cookies
  ipCookie('year', 2014, expires: 365)
  ipCookie("alreadyVisted") || ipCookie("alreadyVisted", [])

  # Init empty OfferList
  $scope.offerList = new OfferList()

  # Load UserLocation and refresh Offers
  successLocateCallback = (userLatLng) ->
    $.each $scope.offerList.offers, (index, offer) ->
      offer.refreshDistanceToUser(userLatLng)

  $scope.userLocation = new UserLocation successLocateCallback

  # Map defaults
  $scope.map = {
    center: { latitude: 51.4296308, longitude: 7.0039007 },
    zoom: 11
  }
]