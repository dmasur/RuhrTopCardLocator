offerConstants = require '../constants/offerConstants'

module.exports =
  mergeFilter: (filter) ->
    this.dispatch(offerConstants.MERGE_FILTER, filter)
  setPosition: (position) ->
    this.dispatch(offerConstants.SET_POSITION, position)
