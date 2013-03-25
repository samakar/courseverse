class CreateVotes < ActiveRecord::Migration
  def up
    create_table :votes do |t|
      t.integer :user_id
      t.integer :verse_id
      t.boolean :thumbs_up, :default => true
 
      t.timestamps
    end
  end

  def down
  	drop_table :votes
  end
end
