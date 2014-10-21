React = require 'react'
ListInfo = require './ListInfo'
Sidebar = require './Sidebar'
OffersList = require './OffersList'

Offers = React.createClass
  getDefaultProps: ->
    offers: []
  render: ->
    <div>
      <div className='col-lg-2'>
        <Sidebar />
      </div>
      <div className='col-lg-10'>
        <ListInfo shownSize={this.props.offers.length} allSize={this.props.offers.length} />
        <OffersList offers={this.props.offers} />
      </div>
    </div>

module.exports = Offers;
