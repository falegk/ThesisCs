class ProjectAssignment < ActiveRecord::Base
  belongs_to :project
  belongs_to :student
end
