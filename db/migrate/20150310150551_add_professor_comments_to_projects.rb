class AddProfessorCommentsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :professor_comments, :string
  end
end
