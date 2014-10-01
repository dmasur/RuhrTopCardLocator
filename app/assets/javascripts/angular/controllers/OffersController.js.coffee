angular.module('ruhrTopCardLocator').controller 'OffersController',
['$scope', '$localStorage', 'UserLocation', 'OfferList', ($scope, $localStorage, UserLocation, OfferList) ->

  # Set Cookies
  $localStorage.year = 2014
  $localStorage.alreadyVisted ||= []

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