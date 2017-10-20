class AddUserIconToCachedPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column :cached_photos, :user_icon, :string
  end
end
