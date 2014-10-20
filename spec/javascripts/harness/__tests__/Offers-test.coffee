jest.dontMock('../src/react/Offers')
jest.dontMock('../src/react/ListInfo')

describe "Offers", ->
  beforeEach ->
    global.React = require('react/addons')
    global.TestUtils = React.addons.TestUtils

  it 'returns right output', ->
    Offers = require '../src/react/Offers'
    offers = TestUtils.renderIntoDocument(Offers())
    div = TestUtils.findRenderedDOMComponentWithClass(offers, 'row')
    expect(div.getDOMNode().textContent).toEqual('5 von 10 Angeboten werden angezeigt')
