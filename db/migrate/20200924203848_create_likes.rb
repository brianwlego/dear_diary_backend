class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :post_likes do |t|
      t.integer :count
      t.belongs_to :user
      t.belongs_to :post

      t.timestamps
    end
  end
end
