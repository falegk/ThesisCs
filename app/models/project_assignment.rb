class ProjectAssignment < ActiveRecord::Base
  belongs_to :project
  belongs_to :student

  accepts_nested_attributes_for :project
  accepts_nested_attributes_for :student
end
