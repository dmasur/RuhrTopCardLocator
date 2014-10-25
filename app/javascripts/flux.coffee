Fluxxor = require 'fluxxor'
filterStore = require './stores/filterStore'
filterActions = require './actions/filterActions'

stores =
  filterStore: new filterStore()

flux = new Fluxxor.Flux(stores, filterActions)

# console.log flux
#
# flux.on "dispatch", (type, payload) ->
#   if (console && console.log)
#     console.log("[Dispatch]", type, payload)

module.exports = flux
