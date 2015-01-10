class Student < ActiveRecord::Base

  belongs_to :user
  has_many :project_assignments
  has_one :project, through: :project_assignments

  accepts_nested_attributes_for :project

end
