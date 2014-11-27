class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.text   :skills_required
      t.binary :attached
      t.references :teacher, index: true
      t.references :student, index: true
      t.timestamps
    end
  end
end
