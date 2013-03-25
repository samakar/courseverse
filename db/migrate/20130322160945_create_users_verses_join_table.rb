class CreateUsersVersesJoinTable < ActiveRecord::Migration
  def up
    create_table :users_verses, :id => false do |t|
      t.integer :user_id
      t.integer :verse_id
    end

    add_index :users_verses, [:user_id, :verse_id]
  end

  def down
    drop_table :users_verses
  end
end