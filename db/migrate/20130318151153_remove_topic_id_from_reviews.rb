class RemoveTopicIdFromReviews < ActiveRecord::Migration
  def up
    remove_column :reviews, :topic_id
  end

  def down
    add_column :reviews, :topic_id, :integer
  end
end
