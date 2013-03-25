class DropUsersVersesJoinTable < ActiveRecord::Migration
  def up
    drop_table :users_verses
  end
end
