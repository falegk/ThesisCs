class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.references :teacher, index: true
      t.references :student, index: true
      t.timestamps
    end
  end
end
