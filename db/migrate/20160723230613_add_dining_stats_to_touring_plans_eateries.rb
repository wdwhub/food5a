class AddDiningStatsToTouringPlansEateries < ActiveRecord::Migration[5.0]
  def change
    add_column :touring_plans_eateries, :dinable_id, :integer
    add_column :touring_plans_eateries, :dinable_type, :string
  end
end
