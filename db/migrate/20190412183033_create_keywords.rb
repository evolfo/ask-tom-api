class CreateKeywords < ActiveRecord::Migration[5.2]
  def change
    create_table :keywords do |t|
      t.text :subject, array: true
      t.text :keyword_type, array: true
      t.text :purpose, array: true

      t.timestamps
    end
  end
end
