class @Offer
  constructor: (offer, userLatLng, visited) ->
    @id = offer.id
    @name = offer.name
    @coords = { latitude: offer.latitude, longitude: offer.longitude }
    @latLng = new google.maps.LatLng offer.latitude, offer.longitude
    @distanceToUser = @.distanceTo(userLatLng)
    @show_description = false
    @visited = visited

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