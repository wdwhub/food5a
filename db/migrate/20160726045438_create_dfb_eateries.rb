class CreateDfbEateries < ActiveRecord::Migration[5.1]
  def change
    create_table :dfb_eateries do |t|
      t.string :name
      t.text :permalink
      t.text :description
      t.string :service
      t.string :type_of_food
      t.string :location
      t.string :tables_in_wonderland
      t.text :reviewlinks
      t.text :important_info
      t.string :you_might_also_like

      t.timestamps
    end
  end
end
