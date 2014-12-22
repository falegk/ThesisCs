class TeachersController < ApplicationController
  before_action :find_current_user
  before_action :find_params_teacher, only: [:profile]
  before_action :find_params_teacher_id, only: [:projects]

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
    @activeDissertation = @teacher.projects.where(status: 'active')
  end

  def dashboard
    redirect_not_teacher
    @projectsCurrentTeacher = Project.all.where(teacher_id: current_user.teacher, status: 'pending')
    @studentsByProject = ProjectAssignment.where(given: false, project_id: @projectsCurrentTeacher)
  end

  def add_project
    redirect_not_teacher
    @project = Project.new
  end



  private
  def find_params_teacher
    @teacher = Teacher.find(params[:id])
  end

  def find_params_teacher_id
    @teacher = Teacher.find(params[:teacher_id])
  end
end
