class AddUserIconToCachedPhoto < ActiveRecord::Migration[5.0]
  def change
    add_column :cached_photos, :user_icon, :string
  end
end
