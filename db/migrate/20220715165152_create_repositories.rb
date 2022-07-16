class CreateRepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :repositories do |t|
      t.references :user, null: false, foreign_key: true
      t.bigint :github_id, null: false, index: { unique: true }
      t.string :name
      t.string :language
      t.string :full_name

      t.timestamps
    end
  end
end
