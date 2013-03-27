class AddPersonIdToSchedules < ActiveRecord::Migration
  def change
  	    add_column :schedules, :person_id, :integer
  end
end
