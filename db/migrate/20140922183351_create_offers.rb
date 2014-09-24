class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :url
      t.string :name
      t.string :description
      t.string :street
      t.string :city
      t.string :website
      t.string :category
      t.string :kind
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
