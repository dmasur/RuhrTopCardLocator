React = require 'react'

Sidebar = React.createClass
  render: ->
    <div className='map-sidebar'>
      <div className='kinds'>
        <h5 className='text-center'>Arten</h5>
        <div className='btn-group-vertical'>
          <label className='btn btn-default'>Kostenlos</label>
          <label className='btn btn-default'>Halber Preis</label>
          <label className='btn btn-default'>Special</label>
        </div>
      </div>
    </div>

module.exports = Sidebar;
