class AddColumnGivenToProjectAssignments < ActiveRecord::Migration
  def change
    add_column :project_assignments, :given, :boolean, null: false, default: false
  end
end
