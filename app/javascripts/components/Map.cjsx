react = require "react"

ReactLeaflet = require "react-leaflet"

module.exports = react.createClass
  render: ->
    ReactLeaflet.Map
      center: [51.505, -0.09]
      zoom: 13
      ReactLeaflet.Marker
        position: [51.505, -0.09]
        ReactLeaflet.Popup null,
          react.DOM.p null,
            react.DOM.strong null, "Hello"
            react.DOM.em null, " World"
