class AddDissertationNumberToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :dissertation_number, :integer
  end
end
