class CreateFacebooks < ActiveRecord::Migration
  def change
    create_table :facebooks, :id => false do |t|
      t.integer :uid, :limit => 8
      t.string :first_name
      t.string :name
      t.string :username
      t.string :pic_square
      t.string :sex
      t.integer :user_id

      t.timestamps
    end

    add_index :facebooks, :user_id, unique: true
    add_index :facebooks, :uid, unique: true
  end
end
