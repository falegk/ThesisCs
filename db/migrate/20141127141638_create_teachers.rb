class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.references :user, index: true

      t.string :department
      t.string :phone
      t.string :grade
      t.string :email_communication
      t.text   :descriptions
      t.timestamps
    end
  end
end
