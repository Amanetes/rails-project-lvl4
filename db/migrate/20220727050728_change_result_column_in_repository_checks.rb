class ChangeResultColumnInRepositoryChecks < ActiveRecord::Migration[6.1]
  def change
    change_column_default :repository_checks, :result, nil
    change_column_null :repository_checks, :result, true
  end
end
