class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :name
      t.string :nickname, null: false
      t.string :image_url
      t.string :token

      t.timestamps
    end
  end
end
