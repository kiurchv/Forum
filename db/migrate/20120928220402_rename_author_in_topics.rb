class RenameAuthorInTopics < ActiveRecord::Migration
  def change
    rename_column :topics, :author_id, :user_id
  end
end
