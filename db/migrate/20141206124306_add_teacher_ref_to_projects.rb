class AddTeacherRefToProjects < ActiveRecord::Migration
  def change
    add_reference :projects, :teacher, index: true
  end
end
