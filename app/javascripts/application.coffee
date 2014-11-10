Offers = require './components/Offers.cjsx'
$ = require 'jQuery'
window.React = React = require 'react'

$ ->
  element = document.getElementById('offer-list')
  offers = $(element).data().offers
  React.renderComponent(Offers(offers: offers), element)
