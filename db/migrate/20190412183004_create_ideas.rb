class CreateIdeas < ActiveRecord::Migration[5.2]
  def change
    create_table :ideas do |t|
      t.string :type
      t.integer :mod

      t.timestamps
    end
  end
end
