class CreateManagementDissertations < ActiveRecord::Migration
  def change
    create_table :management_dissertations do |t|
      t.references :students
      t.references :projects
      t.datetime :delivery_date
      t.datetime :extension_date
      t.string   :status, default: "standby"
      t.timestamps
    end
    add_index :management_dissertations, [:students_id, :projects_id]
    add_index :management_dissertations, :students_id
  end
end
