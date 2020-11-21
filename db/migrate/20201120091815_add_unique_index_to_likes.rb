class AddUniqueIndexToLikes < ActiveRecord::Migration[6.0]
  def change
    add_index :likes, %i[user_id likeable_type likeable_id], unique: true
  end
end
