class CreateRepositoryChecks < ActiveRecord::Migration[6.1]
  def change
    create_table :repository_checks do |t|
      t.references :repository, null: false, foreign_key: true
      t.boolean :passed, default: false
      t.bigint :issues_count, default: 0
      t.string :aasm_state
      t.json :result, null: false, default: []

      t.timestamps
    end
  end
end
