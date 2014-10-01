angular.module('ruhrTopCardLocator').factory 'UserLocation', ['geolocation', '$timeout', (geolocation, $timeout) ->
  class UserLocation
    constructor: (locateCallback) ->
      @coords = @latLng = null
      @locateCallback = locateCallback

    locateUser: ->
      $timeout =>
        geolocation.getLocation().then (data) =>
          @coords = { latitude: data.coords.latitude, longitude: data.coords.longitude }
          @latLng = new L.LatLng(data.coords.latitude, data.coords.longitude)
          @locateCallback(@latLng)
]