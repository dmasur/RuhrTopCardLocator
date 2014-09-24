class OffersController < ApplicationController
  respond_to :json, :html

  def index
    @offers = Offer.all
    respond_with @offers
  end

  def show
    @offer = Offer.find params[:id]
    render layout: nil
  end
end
