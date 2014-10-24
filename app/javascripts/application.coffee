Offers = require './components/Offers.cjsx'
$ = require 'jQuery'
React = require 'react'

$ ->
  element = document.getElementById('offers-list')
  data = $(element).data()
  React.renderComponent(Offers(data), element)
