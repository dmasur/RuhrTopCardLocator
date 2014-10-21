var Offers = require('./Offers.jsx');
var domready = require("domready");
var $ = require("jQuery");
var React = require('react');

domready(function () {
  element = document.getElementById('offers-list')
  data = $(element).data()
  React.renderComponent(Offers(data), element);
});
