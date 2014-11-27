class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|

      t.string :department
      t.string :phone
      t.string :grade
      t.string :email_communication
      t.references :user, index: true
      t.timestamps
    end
  end
end
