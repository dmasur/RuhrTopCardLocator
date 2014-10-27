jest.dontMock('../../src/components/Stars')

Stars = require '../../src/components/Stars'
React = require('react/addons')
TestUtils = React.addons.TestUtils

describe "Stars", ->
  it 'shows 0 full stars', ->
    stars = TestUtils.renderIntoDocument(Stars({count:0}))
    div = TestUtils.scryRenderedDOMComponentsWithClass(stars, 'fa-star')
    expect(div.length).toEqual(0)
    div = TestUtils.scryRenderedDOMComponentsWithClass(stars, 'fa-star-o')
    expect(div.length).toEqual(5)

  it 'shows 3 full stars', ->
    stars = TestUtils.renderIntoDocument(Stars({count:3}))
    div = TestUtils.scryRenderedDOMComponentsWithClass(stars, 'fa-star')
    expect(div.length).toEqual(3)
    div = TestUtils.scryRenderedDOMComponentsWithClass(stars, 'fa-star-o')
    expect(div.length).toEqual(2)
