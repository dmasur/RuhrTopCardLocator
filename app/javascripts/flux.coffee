Fluxxor = require 'fluxxor'
offerStore = require './stores/offerStore'
offerActions = require './actions/offerActions'

stores =
  offerStore: new offerStore()

flux = new Fluxxor.Flux(stores, offerActions)

# console.log flux
#
# flux.on "dispatch", (type, payload) ->
#   if (console && console.log)
#     console.log("[Dispatch]", type, payload)

module.exports = flux
