class ChangeColumnNameToProjectAssignments < ActiveRecord::Migration
  def change
    rename_column :project_assignments, :projects_id, :project_id
    rename_column :project_assignments, :students_id, :student_id
  end
end
