class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :name
      t.text :description
      t.integer :moderator_id

      t.timestamps
    end
  end
end
