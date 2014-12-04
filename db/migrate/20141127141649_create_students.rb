class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.references :user, index: true

      t.string :department
      t.string :phone
      t.string :am
      t.string :email_communication
      t.boolean :dissertation_completed, default: false
      t.text   :skills
      t.text   :description

      t.timestamps
    end
  end
end
