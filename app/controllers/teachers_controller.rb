class TeachersController < ApplicationController
  before_action :auth_user
  before_action :find_current_user
  before_action :find_params_teacher, only: [:profile ]
  before_action :find_params_teacher_id, only: [:projects, :edit_project]
  before_action :number_of_all_destinations, only: [:add_project, :edit]
  before_action :department_empty, if: 'is_student?'


  # Δημόσιο προφίλ
  def profile
  end

  def index # user/teacher
    @allTeachers = Teacher.all
  end

  def edit
  end

  def projects # user/teacher/:id/projects
    @availableDissertations = @teacher.projects.where(status: 'pending')
    @activeDissertations = @teacher.projects.where(status: 'active')
    @completedDissertations = @teacher.projects.where(status: 'completed').order(completion_date: :asc).limit(10)
  end

  def dashboard
    redirect_not_teacher
    @pendingProjectsCurrentTeacher = Project.all.where(teacher_id: current_user.teacher, status: 'pending')
    @activeProjectsOfCurrentTeacher = Project.all.where(teacher_id: current_user.teacher, status: 'active')
    @studentsByProject = ProjectAssignment.where(given: false, project_id: @projectsCurrentTeacher)
  end


  def add_project
    redirect_not_teacher
    @project = Project.new
    @user = User.all.find(current_user)

  end

  def edit_project
    redirect_not_teacher
    if (@teacher.id != current_user.teacher.id) || !@teacher.projects.exists?(params[:id])
      redirect_to root_path, notice: 'Δεν έχετε πρόσβαση στην συγκεκριμένη πτυχιακή.'
    else
      @project = @teacher.projects.find(params[:id])
    end
  end


  def number_of_all_destinations
    @numberOfAll = Project.where(teacher_id: current_user.teacher.id, status: ['active', 'pending']).count
    @numberDissertations = current_user.teacher.dissertation_number
  end

  private
  def find_params_teacher
    @teacher = Teacher.find(params[:id])
  end

  def find_params_teacher_id
    @teacher = Teacher.find(params[:teacher_id])
  end

end
