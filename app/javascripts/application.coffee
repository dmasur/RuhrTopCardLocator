Offers = require './components/Offers.cjsx'
$ = require 'jQuery'
React = require 'react'

$ ->
  element = document.getElementById('offers-list')
  offers = $(element).data().offers
  React.renderComponent(Offers(offers: offers), element)
