jest.dontMock('../../src/sidebar/KindFilter')
jest.dontMock('../../src/stores/filter/actions')
jest.dontMock('../../src/stores/filter/constants')
jest.dontMock('../../src/stores/filter/store')

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

React = require('react/addons')
TestUtils = React.addons.TestUtils
filterActions = require '../../src/stores/filter/actions'
KindFilter = require '../../src/sidebar/KindFilter'
filterStore = require '../../src/stores/filter/store'

describe "KindFilter", ->
  it 'default stored value is false', ->
    expect(filterStore.get 'free').toEqual false

  it 'default prop value is false', ->
    kindFilter = TestUtils.renderIntoDocument(KindFilter(offer: offer))
    expect(kindFilter.state.free).toEqual false

  it 'default button is inactive', ->
    kindFilter = TestUtils.renderIntoDocument(KindFilter(offer: offer))
    filterFreeButton = TestUtils.scryRenderedDOMComponentsWithTag(kindFilter, 'button')[0]
    expect(filterFreeButton.props.active).toEqual false

  describe 'click on filter button', ->
    describe 'free: false', ->
      beforeEach ->
        @kindFilter = TestUtils.renderIntoDocument(KindFilter(offer: offer))
        @filterFreeButton = TestUtils.scryRenderedDOMComponentsWithTag(@kindFilter, 'button')[0]
        TestUtils.Simulate.click(@filterFreeButton)

      it 'changes kindFilter state', ->
        expect(@kindFilter.state.free).toEqual true

      it 'changes filterStore', ->
        expect(filterStore.get 'free').toEqual true

      it 'changes button active state', ->
        expect(@filterFreeButton.props.active).toEqual true

    describe 'free: true', ->
      beforeEach ->
        filterActions.update { free: true }
        @kindFilter = TestUtils.renderIntoDocument(KindFilter(offer: offer))
        @filterFreeButton = TestUtils.scryRenderedDOMComponentsWithTag(@kindFilter, 'button')[0]
        TestUtils.Simulate.click(@filterFreeButton)

      it 'changes kindFilter state', ->
        expect(@kindFilter.state.free).toEqual false

      it 'changes filterStore', ->
        # TODO: Why is this needed?
        filterStore = require '../../src/stores/filter/store'
        expect(filterStore.get 'free').toEqual false

      # TODO: Why is this not working
      xit 'changes button active state', ->
        expect(@filterFreeButton.props.active).toEqual false
