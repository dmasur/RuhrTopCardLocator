React = require 'react'
Button = require 'react-bootstrap/Button'
ButtonGroup = require 'react-bootstrap/ButtonGroup'
offerStore = require '../../stores/offerStore'
Fluxxor = require 'fluxxor'

module.exports = React.createClass
  displayName: 'LocationFilter'
  mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin("offerStore")]

  getStateFromFlux: ->
    position: @getFlux().store("offerStore").position

  getDefaultProps: ->
    flux: require '../../flux'
    geolocation_possible: !!navigator.geolocation

  reset: ->
    store = @getFlux().store('offerStore')
    store.reset()
    @state = @getStateFromFlux()

  getLocation: (event) ->
    navigator.geolocation.getCurrentPosition(@setPosition)
    event.target.blur()

  setPosition: (position) ->
    @state.position = position
    @getFlux().actions.setPosition(position)

  render: ->
    return <div /> unless @props.geolocation_possible

    <div className='location'>
      <ButtonGroup vertical>
        <Button onClick={@getLocation}>Orte mich</Button>
      </ButtonGroup>
    </div>
