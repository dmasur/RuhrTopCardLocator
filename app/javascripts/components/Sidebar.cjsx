React = require 'react'
Button = require 'react-bootstrap/Button'
ButtonGroup = require 'react-bootstrap/ButtonGroup'
KindFilter = require './Sidebar/KindFilter'
CategoryFilter = require './Sidebar/CategoryFilter'
LocationFilter = require './Sidebar/LocationFilter'
VisitedFilter = require './Sidebar/VisitedFilter'

module.exports = React.createClass
  displayName: 'Sidebar'

  render: ->
    <div className='map-sidebar'>
      <div className='well'>
        <h4 className='text-center'>Entfernungen</h4>
        <LocationFilter />
      </div>
      <div className='well'>
        <h4 className='text-center'>Filter</h4>
        <KindFilter />
        <CategoryFilter />
        <VisitedFilter />
      </div>
    </div>
