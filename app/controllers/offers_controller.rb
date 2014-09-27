##
# Controller for the main page and the modal dialog
class OffersController < ApplicationController
  ##
  # Homepage
  # Offers will only be included as json
  def index
    @offers = Offer.all.as_json only: [:id, :name, :longitude, :latitude, :category, :kind]
  end

  ##
  # Modal dialog with more infos
  def show
    @offer = Offer.find params[:id]
    render layout: nil
  end
end
