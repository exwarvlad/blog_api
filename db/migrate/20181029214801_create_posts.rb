class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :header, null: false
      t.string :body, null: false
      t.inet :ip, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
