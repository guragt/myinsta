class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :description
      t.string :image, null: false
      t.boolean :commentable, default: true
      t.references :user, null: false, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :posts, [:user_id, :created_at, :deleted_at]  
  end
end
