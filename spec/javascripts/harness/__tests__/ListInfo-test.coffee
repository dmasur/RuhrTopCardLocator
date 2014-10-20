jest.dontMock('../src/react/ListInfo');

describe "ListInfo", ->
  beforeEach ->
    global.React = require('react/addons')
    global.TestUtils = React.addons.TestUtils

  it 'returns right output with props', ->
    ListInfo = require '../src/react/ListInfo'
    list_info = TestUtils.renderIntoDocument(ListInfo({shownSize:"1", allSize:"2"}))
    div = TestUtils.findRenderedDOMComponentWithTag(list_info, 'div')
    expect(div.getDOMNode().textContent).toEqual('1 von 2 Angeboten werden angezeigt')

  it 'returns right output without props', ->
    ListInfo = require '../src/react/ListInfo'
    list_info = TestUtils.renderIntoDocument(ListInfo())
    div = TestUtils.findRenderedDOMComponentWithTag(list_info, 'div')
    expect(div.getDOMNode().textContent).toEqual('0 von 0 Angeboten werden angezeigt')
