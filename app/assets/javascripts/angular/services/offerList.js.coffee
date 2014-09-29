angular.module('ruhrTopCardLocator').factory 'OfferList', ['Offer', (Offer) ->
  class OfferList
    constructor: ->
      @shownOffers = @offers = []
      @sortOrder = 'name'
      @maxDistance = null
      @showCategoryAction = true
      @showCategoryShips = true
      @showCategoryIndustry = true
      @showCategoryMuseum = true
      @showKindFree = true
      @showKindHalfPrice = true
      @showKindSpecial = true
      @showAlreadyVisited = false
      @showNotVisited = true

    # Load given Offer array
    loadJson: (offers_json) ->
      @offers = $.map offers_json, (offer_json) ->
        new Offer(offer_json)
      @refreshShownOffers()

    # All offers that are shown
    refreshShownOffers: ->
      @shownOffers = _.filter @offers, (offer) =>
        show = offer.inRangeOf(@maxDistance) &&
        @categoryIsShown(offer.category) &&
        @kindIsShown(offer.kind)
        if offer.visited
          show && @showAlreadyVisited
        else
          show && @showNotVisited

    categoryIsShown: (category) ->
      switch category
        when "Erlebnis, Spaß und Action" then @showCategoryAction
        when "Schifffahrt und Bäder" then @showCategoryShips
        when "Erlebnis Industriekultur" then @showCategoryIndustry
        when "Schätze und Museen" then @showCategoryMuseum
        else true

    kindIsShown: (kind) ->
      switch kind
        when "half-price" then @showKindHalfPrice
        when "special" then @showKindSpecial
        else @showKindFree
]