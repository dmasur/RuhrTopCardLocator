ReactFlux = require('react-flux')
filterConstants = require '../constants/filterConstants'
jQuery = require 'jquery'

module.exports = ReactFlux.createStore
  getInitialState: ->
    free: false
    halfPrice: false
    special: false
, [
  [
    filterConstants.UPDATE, (args) ->
      filters = args[0]
      console.log "Set State to #{filters.free}"
      @.setState filters
  ]
]
