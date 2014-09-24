class OffersController < ApplicationController
  def index
    @offers = Offer.all.as_json only: [:id, :name, :longitude, :latitude]
  end

  def show
    @offer = Offer.find params[:id]
    render layout: nil
  end
end
