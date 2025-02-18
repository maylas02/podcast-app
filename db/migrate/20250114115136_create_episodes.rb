# db/migrate/20230101000000_create_episodes.rb
class CreateEpisodes < ActiveRecord::Migration[7.0]
  def change
    create_table :episodes do |t|
      t.string :spotify_id
      t.string :name
      t.string :show
      t.boolean :played, default: false
      t.boolean :finished, default: false
      
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
