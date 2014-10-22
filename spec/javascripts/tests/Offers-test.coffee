jest.dontMock('../src/Offers')
jest.dontMock('../src/ListInfo')
jest.dontMock('../src/OffersList')
jest.dontMock('../src/OfferRow')
jest.dontMock('../src/Sidebar')
jest.dontMock('jquery')

Offers = require '../src/Offers'
React = require('react/addons')
TestUtils = React.addons.TestUtils

offer = {
   "id":2,
   "name":"alpincenter Sommerrodelbahn",
   "category":"Erlebnis, Spaß und Action",
   "kind":"free",
   "description":"Die erste und einzige Sommerrodelbahn im Ruhrgebiet ist ein weite­res Highlight am alpincenter Bottrop. Genießen Sie eine rasante Ab­fahrt bei Geschwindigkeiten von bis zu 42 km/h. Die Gesamtlänge der schienengeführten Bahn beträgt 1.000 m. Ihr Schlitten bringt Sie anschließend komfortabel zurück zur Bergstation – inkl. herr­licher Aussicht. Steile Kurven, ein 360° Panoramakreisel sowie ein Tunnel sorgen für eine Fahrt voller Überraschungen und für puren Rodelspaß für die ganze Familie.",
   "street":"Prosperstraße 299-301",
   "city":"46238 Bottrop",
   "url":"/angebote_eintritt_frei/erlebnis_spass_action/alpincenter_sommerrodelbahn.php",
   "rating":null,
   "coords":{
      "latitude":51.5219278,
      "longitude":6.9638533
   },
   "icon":"/assets/themepark-74e6f6f5e5ac393ff1f9a00911aa0d50.png"
}
describe "Offers", ->
  it 'parses zero offers', ->
    offers = TestUtils.renderIntoDocument(Offers())
    div = TestUtils.findRenderedDOMComponentWithClass(offers, 'list-info')
    expect(div.getDOMNode().textContent).toEqual('0 von 0 Angeboten werden angezeigt')

  it 'shows name of offer', ->
    offers = TestUtils.renderIntoDocument(Offers(offers: [offer]))
    div = TestUtils.findRenderedDOMComponentWithClass(offers, 'name')
    expect(div.getDOMNode().textContent).toEqual('alpincenter Sommerrodelbahn')

  describe 'Filter', ->
    it 'filters free Offers', ->
      offers = TestUtils.renderIntoDocument(Offers(offers: [offer]))
      div = TestUtils.findRenderedDOMComponentWithClass(offers, 'name')
      expect(div.getDOMNode().textContent).toEqual('alpincenter Sommerrodelbahn')
      filterFreeButton = TestUtils.scryRenderedDOMComponentsWithTag(offers, 'button')[0]
      React.addons.TestUtils.Simulate.click(filterFreeButton)
      divs = TestUtils.scryRenderedDOMComponentsWithClass(offers, 'name')
      expect(divs.length).toEqual 0
      React.addons.TestUtils.Simulate.click(filterFreeButton)
      div = TestUtils.findRenderedDOMComponentWithClass(offers, 'name')
      expect(div.getDOMNode().textContent).toEqual('alpincenter Sommerrodelbahn')

    xit 'filters free Offers', ->
      offer.kind = 'halfPrice'
      offers = TestUtils.renderIntoDocument(Offers(offers: [offer]))
      div = TestUtils.findRenderedDOMComponentWithClass(offers, 'name')
      expect(div.getDOMNode().textContent).toEqual('alpincenter Sommerrodelbahn')
      filterFreeButton = TestUtils.scryRenderedDOMComponentsWithTag(offers, 'button')[0]
      React.addons.TestUtils.Simulate.click(filterFreeButton)
      divs = TestUtils.scryRenderedDOMComponentsWithClass(offers, 'name')
      expect(divs.length).toEqual 0
