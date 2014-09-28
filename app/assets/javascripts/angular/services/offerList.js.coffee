angular.module('ruhrTopCardLocator').factory 'OfferList', ['Offer', (Offer) ->
  class OfferList
    constructor: ->
      @shownOffers = @offers = []
      @sortOrder = 'name'
      @maxDistance = null
      @showAction = true
      @showShips = true
      @showIndustry = true
      @showMuseum = true

    loadJson: (offers_json) ->
      @offers = $.map offers_json, (offer_json) ->
        new Offer(offer_json)

      # Fetching Categories list
      @categories = _.uniq $.map @offers, (offer) =>
        offer.category

      @refreshShownOffers()

    # All offers that are shown
    refreshShownOffers: ->
      @shownOffers = _.filter @offers, (offer) =>
        offer.inRangeOf(@maxDistance) &&
        !offer.visited &&
        @categoryIsShown(offer.category)

    categoryIsShown: (category) ->
      switch category
        when "Erlebnis, Spaß und Action" then @showAction
        when "Schifffahrt und Bäder" then @showShips
        when "Erlebnis Industriekultur" then @showIndustry
        when "Schätze und Museen" then @showMuseum
        else true
]