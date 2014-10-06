angular.module('ruhrTopCardLocator').controller 'OffersController',
['$scope', '$localStorage', 'UserLocation', 'OfferList', ($scope, $localStorage, UserLocation, OfferList) ->

  # Set Cookies
  $localStorage.year = 2014
  $localStorage.alreadyVisted ||= []

  # Init empty OfferList
  $scope.offerList = new OfferList()

  $scope.$watch 'offerList.offers', ->
    $scope.offerList.refreshShownOffers()
  , true

  $scope.$watch 'offerList.storage', ->
    $scope.offerList.refreshShownOffers()
  , true

  # Load UserLocation and refresh Offers
  $scope.userLocation = new UserLocation (userLatLng) ->
    $.each $scope.offerList.offers, (index, offer) ->
      offer.refreshDistanceToUser(userLatLng)

  $scope.reset = ->
    $scope.offerList.reset()
    $scope.offerList.refreshShownOffers()

  # Map defaults
  $scope.map =
    center:
      lat: 51.4296308
      lng: 7.0039007
      zoom: 10
    defaults:
      scrollWheelZoom: false
    layers:
      baselayers:
        osm:
          name: 'OpenStreetMap'
          type: 'xyz'
          url: 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'
          layerOptions:
            subdomains: ['a', 'b', 'c']
            attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
      overlays:
        offers:
          name: 'Angebote'
          type: 'markercluster'
          visible: true
]