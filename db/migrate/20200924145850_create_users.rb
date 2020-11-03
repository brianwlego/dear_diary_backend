class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :bio
      t.string :work
      t.string :location
      t.string :last_name
      t.datetime :birthdate
      t.string :img_url
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
