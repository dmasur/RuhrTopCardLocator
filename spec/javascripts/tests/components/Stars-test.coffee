jest.dontMock('../../src/components/Stars')

Stars = require '../../src/components/Stars'
React = require('react/addons')
TestUtils = React.addons.TestUtils

describe "Stars", ->
  it 'shows 0 full stars', ->
    stars = TestUtils.renderIntoDocument(Stars({count:0}))
  #   div = TestUtils.scryRenderedDOMComponentsWithClass(list_info, 'fa-stars')
  #   expect(div.count).toEqual(0)
  #   div = TestUtils.scryRenderedDOMComponentsWithClass(list_info, 'fa-stars-o')
  #   expect(div.count).toEqual(5)
  #
  # it 'shows 3 full stars', ->
  #   stars = TestUtils.renderIntoDocument(Stars({count:3}))
  #   div = TestUtils.scryRenderedDOMComponentsWithClass(list_info, 'fa-stars')
  #   expect(div.count).toEqual(3)
  #   div = TestUtils.scryRenderedDOMComponentsWithClass(list_info, 'fa-stars-o')
  #   expect(div.count).toEqual(2)
