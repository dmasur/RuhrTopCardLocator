angular.module('ruhrTopCardLocator').directive 'offerRow', [ ->
  restrict: 'A'
  templateUrl: 'offer_row.html'
  replace: false
  controller: ['$scope', '$modal', ($scope, $modal) ->
    $scope.openInfo = ->
      modalInstance = $modal.open
        templateUrl: "offers/#{@offer.id}"
  ]
]
