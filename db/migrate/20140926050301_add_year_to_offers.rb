class AddYearToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :year, :string
  end
end
