react = require "react"
ReactLeaflet = require "react-leaflet"
jQuery = require 'jquery'

module.exports = react.createClass
  displayName: 'Map'

  calculateCenter: ->
    latitudeSum = 0
    longitudeSum = 0
    jQuery.each @props.offers, (index, offer) ->
      latitudeSum += offer.coords.latitude
      longitudeSum += offer.coords.longitude

    [latitudeSum / @props.offers.length, longitudeSum / @props.offers.length]

  render: ->
    markers = @props.offers.map (offer) ->
      coords = [offer.coords.latitude, offer.coords.longitude]
      popup = <ReactLeaflet.Popup>{offer.name}</ReactLeaflet.Popup>
      <ReactLeaflet.Marker position={coords}>{popup}</ReactLeaflet.Marker>

    debugger

    react.DOM.div className: 'leaflet-map',
      ReactLeaflet.Map
        center: @calculateCenter()
        zoom: 13
        ReactLeaflet.TileLayer
          url: "http://{s}.tile.osm.org/{z}/{x}/{y}.png"
          attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
        {markers}