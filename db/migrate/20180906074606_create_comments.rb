class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :rating
      t.integer :comment_id
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.timestamps
    end
  end
end
