Fluxxor = require 'fluxxor'
jquery = require 'jquery'
filterConstants = require '../constants/filterConstants'

module.exports = Fluxxor.createStore
  mergeFilter: (new_filters) ->
    # console.log 'merge', @filters, new_filters
    @filters = jquery.extend @filters, new_filters
    # console.log "Set Kind Free State to #{@filters.kinds.free}"
    @.emit("change")

  actions:
    MERGE_FILTER: 'mergeFilter'

  initialize: ->
    @reset()
    this

  reset: ->
    @filters =
      kinds:
        free: false
        halfPrice: false
        special: false

  getKinds: ->
    @filters.kinds
