class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.belongs_to :post, null: false, foreign_key: true
      t.string :img_url

      t.timestamps
    end
  end
end
