class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :content
      t.integer :user_id
      t.integer :schedule_id
      t.integer :topic_id

      t.timestamps
    end
    add_index :reviews, [:user_id, :created_at]
    add_index :reviews, [:schedule_id, :created_at]
  end
end
