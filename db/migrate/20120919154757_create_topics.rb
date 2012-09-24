class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.integer :board_id
      t.integer :author_id

      t.timestamps
    end
  end
end
