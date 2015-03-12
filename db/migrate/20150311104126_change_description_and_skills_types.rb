class ChangeDescriptionAndSkillsTypes < ActiveRecord::Migration
  def change
    change_column :projects, :description, :text
    change_column :projects, :skills_required, :string
  end
end
