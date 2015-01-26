class StudentsController < ApplicationController
  before_action :auth_user
  before_action :find_current_user
  before_action :find_param_student, only: [:profile]

  # Δημόσιο προφίλ
  def profile
    @given_project_to_student = @student.project_assignments.where(given: true)

  end


private
  def find_param_student
    @student = Student.find(params[:id])
  end
end
