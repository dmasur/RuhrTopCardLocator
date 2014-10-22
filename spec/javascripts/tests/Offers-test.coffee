jest.dontMock('../src/Offers')
jest.dontMock('../src/ListInfo')

describe "Offers", ->
  beforeEach ->
    global.React = require('react/addons')
    global.TestUtils = React.addons.TestUtils

  it 'returns right output', ->
    Offers = require '../src/Offers'
    offers = TestUtils.renderIntoDocument(Offers())
    div = TestUtils.findRenderedDOMComponentWithClass(offers, 'col-lg-10')
    expect(div.getDOMNode().textContent).toEqual('0 von 0 Angeboten werden angezeigt')

  describe 'Filter', ->
    xit 'filters free Offers', ->
      Offers = require '../src/Offers'
