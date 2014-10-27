React = require 'react'
Button = require 'react-bootstrap/Button'
ButtonGroup = require 'react-bootstrap/ButtonGroup'
offerStore = require '../../stores/offerStore'
Fluxxor = require 'fluxxor'

module.exports = React.createClass
  displayName: 'VisitedFilter'
  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin("offerStore")]

  getStateFromFlux: ->
    visitedFilter: @getFlux().store("offerStore").getVisitedFilter()

  getDefaultProps: ->
    flux: require '../../flux'

  reset: ->
    store = @getFlux().store('offerStore')
    store.reset()
    @state = @getStateFromFlux()

  updateFilter: (event) ->
    visitedFilter = @state.visitedFilter
    visitedFilter[event.target.name] = !visitedFilter[event.target.name]
    @getFlux().actions.mergeFilter(visited: visitedFilter)
    event.target.blur()

  render: ->
    <div className='kinds'>
      <h5 className='text-center'>Arten</h5>
      <ButtonGroup vertical>
        <Button name='visited' active={@state.visitedFilter.visited} onClick={@updateFilter}>Besucht</Button>
        <Button name='unvisited' active={@state.visitedFilter.unvisited} onClick={@updateFilter}>Unbesucht</Button>
      </ButtonGroup>
    </div>
