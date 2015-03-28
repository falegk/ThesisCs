class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|

      t.timestamps
    end
  end
end
