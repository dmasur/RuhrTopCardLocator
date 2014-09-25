angular.module('ruhrTopCardLocator').factory 'OfferList', ['Offer', (Offer) ->
  class OfferList
    constructor: ->
      @shownOffers = @offers = []
      @sortOrder = 'name'
      @maxDistance = null

    loadJson: (offers_json) ->
      @offers = $.map offers_json, (offer_json) ->
        new Offer(offer_json)
      @refreshShownOffers()

    # All offers that are shown
    refreshShownOffers: ->
      @shownOffers = _.filter @offers, (offer) =>
        offer.inRangeOf(@maxDistance) && !offer.visited
]