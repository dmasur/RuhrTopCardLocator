angular.module('ruhrTopCardLocator').factory 'UserLocation', ['geolocation', (geolocation) ->
  class UserLocation
    constructor: ->
      @coords = @latLng = null

    locateUser: (callback) ->
      geolocation.getLocation().then (data) ->
        @coords = { latitude: data.coords.latitude, longitude: data.coords.longitude }
        @latLng = new google.maps.LatLng(data.coords.latitude, data.coords.longitude)
        callback(@latLng)
]