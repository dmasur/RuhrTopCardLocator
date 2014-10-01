angular.module('ruhrTopCardLocator').factory 'OfferList',
['Offer', '$localStorage', (Offer, $localStorage, $sessionStorage) ->
  class OfferList
    constructor: ->
      @shownOffers = @offers = []
      @storage = $localStorage.$default
        sortOrder: 'name'
        maxDistance: null
        showCategoryAction: true
        showCategoryShips: true
        showCategoryIndustry: true
        showCategoryMuseum: true
        showKindFree: true
        showKindHalfPrice: true
        showKindSpecial: true
        showAlreadyVisited: false
        showNotVisited: true

    # Load given Offer array
    loadJson: (offers_json) ->
      @offers = $.map offers_json, (offer_json) ->
        new Offer(offer_json)
      @refreshShownOffers()

    # All offers that are shown
    refreshShownOffers: ->
      @shownOffers = _.filter @offers, (offer) =>
        show = offer.inRangeOf(@storage.maxDistance) &&
        @categoryIsShown(offer.category) &&
        @kindIsShown(offer.kind)
        if offer.visited
          show && @storage.showAlreadyVisited
        else
          show && @storage.showNotVisited

    categoryIsShown: (category) ->
      switch category
        when "Erlebnis, Spaß und Action" then @storage.showCategoryAction
        when "Schifffahrt und Bäder" then @storage.showCategoryShips
        when "Erlebnis Industriekultur" then @storage.showCategoryIndustry
        when "Schätze und Museen" then @storage.showCategoryMuseum
        else true

    kindIsShown: (kind) ->
      switch kind
        when "half-price" then @storage.showKindHalfPrice
        when "special" then @storage.showKindSpecial
        else @storage.showKindFree
]