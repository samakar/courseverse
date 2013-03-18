class CreateVerses < ActiveRecord::Migration
  def change
    create_table :verses do |t|
      t.string :content
      t.integer :topic_id
      t.integer :review_id
      t.integer :score

      t.timestamps
    end
  end
end
