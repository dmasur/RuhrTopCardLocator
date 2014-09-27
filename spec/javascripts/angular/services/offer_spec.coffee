describe "RuhrTopCard Locator", () ->

  beforeEach module('ruhrTopCardLocator')

  describe "test", () ->
    it "should return a list of gems", inject (Offer) ->
      expect(Offer).toBeDefined();

