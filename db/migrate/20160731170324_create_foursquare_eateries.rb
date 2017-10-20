class CreateFoursquareEateries < ActiveRecord::Migration[5.1]
  def change
    create_table :foursquare_eateries do |t|
      t.string :name
      t.string :venue_id
      t.string :address
      t.string :cross_street
      t.string :lat
      t.string :lng
      t.string :alt_venues
      t.string :searched_for
      t.datetime :archived_at
      t.text :categories
      t.string :referral_id
      t.text :location
      t.text :canonical_url
      t.boolean :verified
      t.boolean :dislike
      t.boolean :ok
      t.decimal :rating, :decimal, precision: 10, scale: 2
      t.string :rating_color
      t.string :rating_signals
      t.boolean :allow_menu_url_edit
      t.string :specials
      t.text :wdw_uri
      t.belongs_to :venue, foreign_key: true

      t.timestamps
    end
  end
end
