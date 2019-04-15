class CreateIdeas < ActiveRecord::Migration[5.2]
  def change
    create_table :ideas do |t|
      t.string :idea_type
      t.integer :mod

      t.timestamps
    end
  end
end
