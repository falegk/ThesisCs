class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|

      t.string :title
      t.string :description
      t.text   :skills_required
      t.string :status, default: 'pending'
      t.binary :attached
      t.string :keywords
      t.datetime :start_date
      t.datetime :completion_date
      t.boolean :prolongation, default: false
      t.timestamps
    end
  end
end
