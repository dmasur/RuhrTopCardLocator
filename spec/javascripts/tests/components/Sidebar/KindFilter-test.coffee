jest.dontMock('../../../src/components/Sidebar/KindFilter')
jest.dontMock('../../../src/actions/offerActions')
jest.dontMock('../../../src/constants/offerConstants')
jest.dontMock('../../../src/stores/offerStore')
jest.dontMock('fluxxor')
jest.dontMock('util')
jest.dontMock('../../../src/flux')

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
KindFilter = require '../../../src/components/Sidebar/KindFilter'
flux = require '../../../src/flux'
offerStore = flux.store('offerStore')

describe "KindFilter", ->
  beforeEach ->
    @kindFilter = TestUtils.renderIntoDocument(KindFilter(offer: offer))
    @kindFilter.reset()

  it 'default stored value is false', ->
    expect(offerStore.getKinds().free).toEqual false

  it 'default prop value is false', ->
    expect(@kindFilter.state.kindFilter.free).toEqual false

  it 'default button is inactive', ->
    filterFreeButton = TestUtils.scryRenderedDOMComponentsWithTag(@kindFilter, 'button')[0]
    expect(filterFreeButton.props.active).toEqual false

  describe 'click on filter button', ->
    describe 'free: false', ->
      beforeEach ->
        @filterFreeButton = TestUtils.scryRenderedDOMComponentsWithTag(@kindFilter, 'button')[0]
        TestUtils.Simulate.click(@filterFreeButton)

      it 'changes kindFilter state', ->
        expect(@kindFilter.state.kindFilter.free).toEqual true

      it 'changes button active state', ->
        expect(@filterFreeButton.props.active).toEqual true

    describe 'free: true', ->
      beforeEach ->
        offerStore.mergeFilter { kinds: { free: true } }
        @kindFilter = TestUtils.renderIntoDocument(KindFilter(offer: offer))
        @filterFreeButton = TestUtils.scryRenderedDOMComponentsWithTag(@kindFilter, 'button')[0]
        TestUtils.Simulate.click(@filterFreeButton)

      it 'changes kindFilter state', ->
        expect(@kindFilter.state.kindFilter.free).toEqual false

      it 'changes button active state', ->
        expect(@filterFreeButton.props.active).toEqual false
