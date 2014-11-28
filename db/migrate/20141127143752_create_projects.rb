class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :teacher, index: true
      t.references :student, index: true
      t.string :title
      t.string :description
      t.text   :skills_required
      t.boolean :completed, default: false
      t.binary :attached

      t.timestamps
    end
  end
end
