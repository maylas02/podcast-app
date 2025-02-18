class CreateShows < ActiveRecord::Migration[7.2]
  def change
    create_table :shows do |t|
      t.string :title
      t.text :description
      t.string :spotify_id

      t.timestamps
    end
  end
end
