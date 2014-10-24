React = require 'react'
Button = require 'react-bootstrap/Button'
ButtonGroup = require 'react-bootstrap/ButtonGroup'
filterStore = require '../stores/filter/store'
filterActions = require '../stores/filter/actions'
ReactFlux = require 'react-flux'

module.exports = React.createClass
  mixins: [ ReactFlux.mixin(filterStore) ]

  getStateFromStores: ->
    free: filterStore.state.get('free')
    halfPrice: filterStore.state.get('halfPrice')
    special: filterStore.state.get('special')

  updateFilter: (event) ->
    filters = @state
    filters[event.target.name] = !filters[event.target.name]
    filterActions.update(filters)
    event.target.blur()

  render: ->
    <div className='kinds'>
      <h5 className='text-center'>Arten</h5>
      <ButtonGroup vertical>
        <Button name='free' active={@state.free} onClick={@.updateFilter}>Kostenlos</Button>
        <Button name='halfPrice' active={@state.halfPrice} onClick={@.updateFilter}>Halber Preis</Button>
        <Button name='special' active={@state.special} onClick={@.updateFilter}>Spezial</Button>
      </ButtonGroup>
    </div>
