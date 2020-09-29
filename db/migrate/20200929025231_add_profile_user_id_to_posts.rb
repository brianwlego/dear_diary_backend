class AddProfileUserIdToPosts < ActiveRecord::Migration[6.0]
  def change
      add_column :posts, :profile_user_id, :integer
  end
end
