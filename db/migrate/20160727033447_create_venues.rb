class CreateVenues < ActiveRecord::Migration[5.1]
  def change
    create_table :venues do |t|
      t.string :name
      t.text :permalink
      t.string :category_code
      t.string :portion_size
      t.string :cost_code
      t.string :cuisine
      t.string :phone_number
      t.string :entree_range
      t.string :when_to_go
      t.string :parking
      t.string :bar
      t.string :wine_list
      t.string :dress
      t.string :awards
      t.string :breakfast_hours
      t.string :lunch_hours
      t.string :dinner_hours
      t.string :house_specialties
      t.string :counter_quality_rating
      t.string :counter_value_rating
      t.float :table_quality_rating
      t.float :table_value_rating
      t.float :overall_rating
      t.float :service_rating
      t.float :friendliness_rating
      t.integer :thumbs_up
      t.string :adult_breakfast_menu_url
      t.string :adult_lunch_menu_url
      t.string :adult_dinner_menu_url
      t.string :child_breakfast_menu_url
      t.string :child_lunch_menu_url
      t.string :child_dinner_menu_url
      t.boolean :requires_credit_card
      t.boolean :requires_pre_payment
      t.datetime :extinct_on
      t.datetime :opened_on
      t.string :disney_permalink
      t.string :code
      t.string :short_name
      t.boolean :accepts_tiw
      t.boolean :accepts_reservations
      t.boolean :kosher_available
      t.string :location_details
      t.integer :operator_id
      t.text :operator_url
      t.string :operator_type

      t.timestamps
    end
  end
end
