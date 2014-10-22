React = require 'react'
Button = require 'react-bootstrap/Button'
ButtonGroup = require 'react-bootstrap/ButtonGroup'

Sidebar = React.createClass
  render: ->
    <div className='map-sidebar'>
      <div className='well'>
        <h4 className='text-center'>Filter</h4>
        <div className='kinds'>
          <h5 className='text-center'>Arten</h5>
          <ButtonGroup vertical onClick={this.props.changeFilter}>
            <Button name='free'>Kostenlos</Button>
            <Button name='halfPrice'>Halber Preis</Button>
            <Button name='special'>Special</Button>
          </ButtonGroup>
        </div>
      </div>
    </div>

module.exports = Sidebar;
