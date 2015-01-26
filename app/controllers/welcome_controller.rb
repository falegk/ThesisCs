class WelcomeController < ApplicationController
  before_action :auth_user
  # Ελέγχουν αν υπάρχει ρόλος στον user
  # άν δεν υπάρχει, τρέχει η add_role_to_user
  before_action  :has_role?
  before_action  :add_role_to_user, if: :has_role?
  before_action  :department_empty
  before_action  :project_statistics, only: [ :index ]


  # View methods
  def index
  end


  def project_statistics
    @numberOfAvailableDissertations = Project.where(status: 'pending').count
    @numberOfActiveDissertations = Project.where(status: 'active').count
    @numberOfCompletedDissertation = Project.where(status: 'completed').count
    @numberOfStudents = Student.count
  end

end
