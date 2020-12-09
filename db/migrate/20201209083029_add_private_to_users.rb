class AddPrivateToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :private, :boolean, default: false
  end
end
