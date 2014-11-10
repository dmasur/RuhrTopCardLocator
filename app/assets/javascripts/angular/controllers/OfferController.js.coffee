angular.module('ruhrTopCardLocator').controller 'OfferController',
['$scope', 'Offer', ($scope, Offer) ->
  $scope.loadOffer = (offer) ->
    $scope.offer = new Offer(offer)
]