class CreateProjectsStudents < ActiveRecord::Migration
  def change
    create_table :projects_students, id: false do |t|
      t.references :project
      t.references :student
      t.string :status , default: "standby"
    end
    add_index :projects_students, [:project_id,:student_id]
    add_index :projects_students, :student_id
  end
end
