filterConstants = require '../constants/filterConstants'

module.exports =
  mergeFilter: (filter) ->
    this.dispatch(filterConstants.MERGE_FILTER, filter)
