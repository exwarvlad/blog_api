class CreateMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :marks do |t|
      t.integer :num, null: false
      t.references :post, foreign_key: true, null: false

      t.timestamps
    end
  end
end
