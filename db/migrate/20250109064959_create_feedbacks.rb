class CreateFeedbacks < ActiveRecord::Migration[7.0]
  def change
    create_table :feedbacks do |t|
      t.integer :rating
      t.text :comment
      t.string :podcast_id

      t.timestamps
    end
  end
end