React = require 'react'
Button = require 'react-bootstrap/Button'
ButtonGroup = require 'react-bootstrap/ButtonGroup'

Sidebar = React.createClass
  updateFilter: (event) ->
    filters = this.props.filters
    filters.free = !filters.free if event.target.name == 'free'
    filters.halfPrice = !filters.halfPrice if event.target.name == 'halfPrice'
    filters.special = !filters.special if event.target.name == 'special'

    event.target.blur()
    this.props.updateFilter(filters)
    
  render: ->
    <div className='map-sidebar'>
      <div className='well'>
        <h4 className='text-center'>Filter</h4>
        <div className='kinds'>
          <h5 className='text-center'>Arten</h5>
          <ButtonGroup vertical>
            <Button name='free' active={this.props.filters.free} onClick={this.updateFilter}>Kostenlos</Button>
            <Button name='halfPrice' active={this.props.filters.halfPrice} onClick={this.updateFilter}>Halber Preis</Button>
            <Button name='special' active={this.props.filters.special} onClick={this.updateFilter}>Spezial</Button>
          </ButtonGroup>
        </div>
      </div>
    </div>

module.exports = Sidebar;
