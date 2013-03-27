class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.integer :role
      t.integer :user_id

      t.timestamps
    end

    add_index  :people, [:role, :lastname]
    add_index  :people, :user_id
  end
end
