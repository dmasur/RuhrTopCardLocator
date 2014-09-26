class AddGooglePlaceInfosToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :google_place_id, :string
    add_column :offers, :google_place_rating, :string
    add_column :offers, :google_place_url, :string
  end
end
