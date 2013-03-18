class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.string :code
      t.integer :college_id

      t.timestamps
    end
    add_index :courses, [:college_id, :title]
  end
end
