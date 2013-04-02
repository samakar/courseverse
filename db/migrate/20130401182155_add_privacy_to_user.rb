class AddPrivacyToUser < ActiveRecord::Migration
  def change
    add_column :users, :privacy, :integer, default: 0
  end
end
