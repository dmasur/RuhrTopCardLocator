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

var ListInfo = require('./ListInfo');

var Offers = React.createClass({displayName: 'Offers',
  render: function() {
      return (
        React.DOM.div({className: "row"}, 
          React.DOM.div({className: "col-lg-10"}, 
            ListInfo({shownSize: "5", allSize: "10"})
          )
        )
      );
    }
});

module.exports = Offers;

var domready = require("domready");

domready(function () {
  React.renderComponent(Offers(), document.getElementById('offers-list'));
});

},{"./ListInfo":2,"domready":1}]},{},[2,3]);
