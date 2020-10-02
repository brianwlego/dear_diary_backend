class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :bio, :string
    add_column :users, :work, :string
    add_column :users, :location, :string
  end
end
