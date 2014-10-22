React = require 'react'
Button = require 'react-bootstrap/Button'
ButtonGroup = require 'react-bootstrap/ButtonGroup'
KindFilter = require './sidebar/KindFilter'

module.exports = React.createClass
  render: ->
    <div className='map-sidebar'>
      <div className='well'>
        <h4 className='text-center'>Filter</h4>
        <KindFilter filters={this.props.filters} updateFilter={this.props.updateFilter} />
      </div>
    </div>
