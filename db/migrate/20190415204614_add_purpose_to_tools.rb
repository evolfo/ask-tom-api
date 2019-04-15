class AddPurposeToTools < ActiveRecord::Migration[5.2]
  def change
    add_column :tools, :purpose, :string
  end
end
