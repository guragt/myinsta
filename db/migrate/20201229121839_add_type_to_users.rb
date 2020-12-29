class AddTypeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :type, :string, default: 'User'
    remove_column :users, :admin, :boolean, default: false
  end
end
