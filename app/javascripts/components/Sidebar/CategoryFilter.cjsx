React = require 'react'
Button = require 'react-bootstrap/Button'
ButtonGroup = require 'react-bootstrap/ButtonGroup'
offerStore = require '../../stores/offerStore'
Fluxxor = require 'fluxxor'

module.exports = React.createClass
  displayName: 'categoryFilter'
  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin("offerStore")]

  getStateFromFlux: ->
    categoryFilter: @.getFlux().store("offerStore").getCategories()

  getDefaultProps: ->
    flux: require '../../flux'

  reset: ->
    store = @.getFlux().store('offerStore')
    store.reset()
    @state = @getStateFromFlux()

  updateFilter: (event) ->
    categoryFilter = @state.categoryFilter
    categoryFilter[event.target.name] = !categoryFilter[event.target.name]
    @.getFlux().actions.mergeFilter(categories: categoryFilter)
    event.target.blur()

  render: ->
    return unless categoryFilter.getKinds().free

    <div className='categories'>
      <h5 className='text-center'>Kategorien</h5>
      <ButtonGroup vertical>
        <Button name='free' active={@state.categoryFilter.free} onClick={@.updateFilter}>Kostenlos</Button>
        <Button name='halfPrice' active={@state.categoryFilter.halfPrice} onClick={@.updateFilter}>Halber Preis</Button>
        <Button name='special' active={@state.categoryFilter.special} onClick={@.updateFilter}>Spezial</Button>
      </ButtonGroup>
    </div>
