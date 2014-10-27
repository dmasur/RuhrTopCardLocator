React = require 'react'
Button = require 'react-bootstrap/Button'
ButtonGroup = require 'react-bootstrap/ButtonGroup'
offerStore = require '../../stores/offerStore'
Fluxxor = require 'fluxxor'

module.exports = React.createClass
  displayName: 'KindFilter'
  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin("offerStore")]

  getStateFromFlux: ->
    kindFilter: @.getFlux().store("offerStore").getKinds()

  getDefaultProps: ->
    flux: require '../../flux'

  reset: ->
    store = @.getFlux().store('offerStore')
    # console.log 'KindFilter.reset: Before', store.getKinds()
    store.reset()
    # console.log 'KindFilter.reset: After', store.getKinds()
    @state = @getStateFromFlux()

  updateFilter: (event) ->
    kindFilter = @state.kindFilter
    kindFilter[event.target.name] = !kindFilter[event.target.name]
    @.getFlux().actions.mergeFilter(kinds: kindFilter)
    event.target.blur()

  render: ->
    <div className='kinds'>
      <h5 className='text-center'>Arten</h5>
      <ButtonGroup vertical>
        <Button name='free' active={@state.kindFilter.free} onClick={@.updateFilter}>Kostenlos</Button>
        <Button name='halfPrice' active={@state.kindFilter.halfPrice} onClick={@.updateFilter}>Halber Preis</Button>
        <Button name='special' active={@state.kindFilter.special} onClick={@.updateFilter}>Spezial</Button>
      </ButtonGroup>
    </div>
