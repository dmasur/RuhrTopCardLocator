angular.module('ruhrTopCardLocator').factory 'UserLocation', ['geolocation', '$timeout', (geolocation, $timeout) ->
  class UserLocation
    constructor: (locateCallback) ->
      @locateCallback = locateCallback

    locateUser: ->
      $timeout =>
        geolocation.getLocation().then (data) =>
          @latLng = new L.LatLng(data.coords.latitude, data.coords.longitude)
          @locateCallback(@latLng)
]