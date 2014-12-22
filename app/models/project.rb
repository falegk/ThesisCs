class Project < ActiveRecord::Base
  belongs_to :teacher
  has_many :project_assignments
  has_many :students, through: :project_assignments

  accepts_nested_attributes_for :students

  serialize :student_id, Array


  #validates :student_id, presence: true
end
