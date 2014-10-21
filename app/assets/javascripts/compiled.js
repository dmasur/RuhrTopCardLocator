(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
/*!
  * domready (c) Dustin Diaz 2014 - License MIT
  */
!function (name, definition) {

  if (typeof module != 'undefined') module.exports = definition()
  else if (typeof define == 'function' && typeof define.amd == 'object') define(definition)
  else this[name] = definition()

}('domready', function () {

  var fns = [], listener
    , doc = document
    , hack = doc.documentElement.doScroll
    , domContentLoaded = 'DOMContentLoaded'
    , loaded = (hack ? /^loaded|^c/ : /^loaded|^i|^c/).test(doc.readyState)


  if (!loaded)
  doc.addEventListener(domContentLoaded, listener = function () {
    doc.removeEventListener(domContentLoaded, listener)
    loaded = 1
    while (listener = fns.shift()) listener()
  })

  return function (fn) {
    loaded ? fn() : fns.push(fn)
  }

});

},{}],2:[function(require,module,exports){
/** @jsx React.DOM */

var ListInfo = React.createClass({displayName: 'ListInfo',
  getDefaultProps: function() {
    return {
      shownSize: 0,
      allSize: 0
    };
  },
  render: function() {
      return (
        React.DOM.div({className: "text-center lead"}, 
          this.props.shownSize, " von ", this.props.allSize, " Angeboten werden angezeigt"
        )
      );
    }
});

module.exports = ListInfo;

},{}],3:[function(require,module,exports){
/** @jsx React.DOM */

var OffersInfo = React.createClass({displayName: 'OffersInfo',
  getDefaultProps: function() {
    return {
      offers: []
    };
  },
  render: function() {
    return (
      React.DOM.div(null, 
        OfferInfo({offer: offer})
      )
    );
  }
});

module.exports = OffersInfo;

},{}],4:[function(require,module,exports){
/** @jsx React.DOM */

var OfferRow = React.createClass({displayName: 'OfferRow',
  render: function() {
    return (
      React.DOM.tr(null, 
        React.DOM.td(null, this.props.offer.name), 
        React.DOM.td(null, this.props.offer.category), 
        React.DOM.td(null), 
        React.DOM.td(null)
      )
    );
  }
});

module.exports = OfferRow;

},{}],5:[function(require,module,exports){
/** @jsx React.DOM */

var ListInfo = require('./ListInfo');
var Sidebar = require('./Sidebar');
var OffersList = require('./OffersList');

var Offers = React.createClass({displayName: 'Offers',
  getDefaultProps: function() {
    return {
      offers: []
    };
  },
  render: function() {
    return (
      React.DOM.div(null, 
        React.DOM.div({className: "col-lg-2"}, 
          Sidebar(null)
        ), 
        React.DOM.div({className: "col-lg-10"}, 
          ListInfo({shownSize: this.props.offers.length, allSize: this.props.offers.length}), 
          OffersList({offers: this.props.offers})
        )
      )
    );
  }
});

module.exports = Offers;

if (typeof($) != "undefined") {
  var domready = require("domready");

  domready(function () {
    element = document.getElementById('offers-list')
    data = $(element).data()
    React.renderComponent(Offers(data), element);
  });
}

},{"./ListInfo":2,"./OffersList":6,"./Sidebar":7,"domready":1}],6:[function(require,module,exports){
/** @jsx React.DOM */

var OfferRow = require('./OfferRow');

var OffersList = React.createClass({displayName: 'OffersList',
  getDefaultProps: function() {
    return {
      offers: []
    };
  },
  render: function() {
    var rows = [];
    this.props.offers.forEach(function(offer) {
      rows.push(OfferRow({offer: offer}));
    });
    return (
      React.DOM.table({className: "table table-striped"}, 
        React.DOM.thead(null, 
          React.DOM.tr(null, 
            React.DOM.td(null, "Name"), 
            React.DOM.td(null, "Kategorie"), 
            React.DOM.td(null, "Bewertung"), 
            React.DOM.td(null, "Entfernung"), 
            React.DOM.td(null)
          )
        ), 
        React.DOM.tbody(null, 
          rows
        )
      )
    );
  }
});

module.exports = OffersList;

},{"./OfferRow":4}],7:[function(require,module,exports){
/** @jsx React.DOM */

var Sidebar = React.createClass({displayName: 'Sidebar',
  render: function() {
    return (
      React.DOM.div(null
      )
    );
  }
});

module.exports = Sidebar;

},{}]},{},[2,3,4,5,6,7]);
