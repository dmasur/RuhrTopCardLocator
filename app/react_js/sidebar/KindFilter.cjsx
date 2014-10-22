React = require 'react'
Button = require 'react-bootstrap/Button'
ButtonGroup = require 'react-bootstrap/ButtonGroup'

module.exports = React.createClass
  updateFilter: (event) ->
    filters = this.props.filters
    filters[event.target.name] = !filters[event.target.name]

    event.target.blur()
    this.props.updateFilter(filters)

  render: ->
    <div className='kinds'>
      <h5 className='text-center'>Arten</h5>
      <ButtonGroup vertical>
        <Button name='free' active={this.props.filters.free} onClick={this.updateFilter}>Kostenlos</Button>
        <Button name='halfPrice' active={this.props.filters.halfPrice} onClick={this.updateFilter}>Halber Preis</Button>
        <Button name='special' active={this.props.filters.special} onClick={this.updateFilter}>Spezial</Button>
      </ButtonGroup>
    </div>
