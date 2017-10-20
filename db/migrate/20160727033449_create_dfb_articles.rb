class CreateDfbArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :dfb_articles do |t|
      t.string :title
      t.text :link
      t.belongs_to :dfb_eatery, foreign_key: true
      t.belongs_to :venue, foreign_key: true

      t.timestamps
    end
  end
end
