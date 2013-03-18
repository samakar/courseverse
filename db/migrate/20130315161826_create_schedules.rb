class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :year
      t.integer :semester
      t.integer :course_id

      t.timestamps
    end
    add_index :schedules, :course_id
  end
end
