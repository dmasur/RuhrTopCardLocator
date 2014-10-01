angular.module('ruhrTopCardLocator').controller 'OfferController',
['$scope','Offer', ($scope, Offer) ->
  $scope.offer = null

  $scope.loadOffer = (json) ->
    $scope.offer = new Offer(json)
]