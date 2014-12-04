class CreateProjectAssignments < ActiveRecord::Migration
  def change
    create_table :project_assignments do |t|
      t.references :projects
      t.references :students
      #t.timestamps
    end
  end
end
