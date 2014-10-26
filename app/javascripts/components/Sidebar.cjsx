React = require 'react'
Button = require 'react-bootstrap/Button'
ButtonGroup = require 'react-bootstrap/ButtonGroup'
KindFilter = require './Sidebar/KindFilter'
LocationFilter = require './Sidebar/LocationFilter'

module.exports = React.createClass
  render: ->
    <div className='map-sidebar'>
      <div className='well'>
        <h4 className='text-center'>Filter</h4>
        <LocationFilter />
        <KindFilter />
      </div>
    </div>
