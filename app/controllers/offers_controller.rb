class OffersController < ApplicationController
  respond_to :json, :html
  def index
    @offers = Offer.all
    respond_with @offers
  end
end
