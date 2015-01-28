class ProjectsController < ApplicationController
  before_action :auth_user

  # @return projects
  #before_action :all_projects, only: [ :index, :show ]
  before_action :active_projects, only: [ :index ]
  before_action :pending_projects, only: [ :index ]
  before_action :completed_projects, only: [ :index ]
  before_action :current_project, only: [ :show, :update, :destroy, :project_completed,:project_prolongation, :create_assignment,:delete_assignments,:destroy_assignment, :update_assignment ]

  # students valid
  before_action :given_to_students, only: [ :show , :names_of_students]
  before_action :names_of_students, only: [ :show ]
  #before_action :redirect_not_student, only: []
  #before_action :redirect_not_teacher, only: []
  before_action :expressed_interest, only: [ :show ]
  before_action  :department_empty


  def index
    respond_to do |format|
      format.html # index.html.erb
      ajax_respond format, :section_id => "pendingProjectsPage"
      ajax_respond format, :section_id => "activeProjectsPage"
    end
  end


  def show
    if is_student?
      #Αν το θεμα ειναι επιλεγμενο απο τον student που ειναι συνδεμενος (true,false)
      @project_is_selected = @currentProject.project_assignments.where(student_id: current_user.student.id).exists?
    end
  end


  def new
    @project = Project.new
  end

  def edit
  end

  def destroy
    current_user.teacher.projects.find(params[:id]).destroy
    redirect_to teacher_dashboard_path , :flash => { :success => t('messages.success.projects.thesis_delete_successfully') }
  end

  def create
    redirect_not_teacher
    @project = Project.new(project_params)
    @project.teacher = current_user.teacher
    respond_to do |f|
      if @project.save
        f.html {redirect_to project_path(@project), :flash => { :success => t('messages.success.projects.thesis_create_successfully_html') }}
        #f.json {render json: @user, status: :created, location: @user}
      else
        f.html {render template: 'teachers/add_project' }
      end
    end
  end

  # update project from teacher /user/teacher/:id/projects/:id/edit
  def update
    redirect_not_teacher
    respond_to do |f|
      if @currentProject.update(project_params)
        f.html {redirect_to project_path(@currentProject), :flash => { :success => t('messages.success.projects.thesis_update_successfully') }}
        #f.json {render json: @user, status: :created, location: @user}
      else
        f.html {render action: "edit", :flash => { :error => "Error" } }
      end
    end
  end

  def update_assignment
      redirect_not_teacher
        @currentProject.project_assignments.where(assignment_params).update_all(given: true)
        @currentProject.project_assignments.where(given: false).destroy_all
        ProjectAssignment.where(assignment_params).destroy_all(given: false)
        @currentProject.update!(status: 'active', start_date: Time.now, completion_date: 1.year.from_now)

        @currentProject.project_assignments.where(given: true).each do |p|
          UserMailer.project_assignment(current_user.teacher,p.student,@currentProject).deliver
        end
        redirect_to project_path(params[:id]),:flash => { :success => 'Η πτυχιακή εργασία ανατέθηκε επιτυχώς.'}
  end

  def project_completed
    redirect_not_teacher
    @currentProject.update!(status: 'completed')
    redirect_to teacher_dashboard_path ,:flash => { :success => t('messages.success.projects.thesis_completed_successfully')}
  end

  def project_prolongation
    redirect_not_teacher
    if @currentProject.prolongation == true
      redirect_to teacher_dashboard_path , :flash =>  { :notice => t('messages.alert.projects.already_been_given_prolongation')}
    else
      @currentProject.update!(prolongation: true)
      redirect_to teacher_dashboard_path, :flash =>  { :success => t('messages.success.projects.prolongation_has_given_successfully')}
    end
  end

  def delete_assignments
    redirect_not_teacher
    @currentProject.project_assignments.destroy_all
    @currentProject.update!(status: 'pending', prolongation: false)
    redirect_to teacher_dashboard_path, :flash => { :success => 'Η πτυχιακή μεταφέρθηκε επιτυχώς στις "Διαθέσιμες Πτυχιακές" και είναι έτοιμη να δοθεί σε άλλους φοιτητές.' }
  end

  # Expression of interest from the student
  def create_assignment
    @currentProject.project_assignments.create(student_id: current_user.student.id)
    UserMailer.expression_interest(@currentProject.teacher,current_user.student,@currentProject).deliver
    redirect_to project_path(params[:id])
  end

  def destroy_assignment
    @currentProject.project_assignments.find_by(student_id: current_user.student.id).destroy
    redirect_to project_path(params[:id])
  end

  def expressed_interest
    @studentsList = @currentProject.project_assignments.all
  end


  #@return @given_project_to_students
  # επιστρέφει πίνακα με μέχρι 2 εγγραφές που ειναι given: true απο τον πίνακα project_assignments
  def given_to_students
    @given_project_to_students = @currentProject.project_assignments.where(given: true).first(2)
  end

  # @return [detailsOfStudents]
  def names_of_students
    @detailsOfStudents = []
    @given_project_to_students.each do |s|
      @detailsOfStudents << s.student
    end
     @detailsOfStudents
  end

  # @return @allProjects
  def all_projects
    @allProjects = Project.all
  end

  # @return @pendingProjects
  def pending_projects
    @pendingProjects = Project.all.where(status: 'pending').order('created_at DESC').paginate( :page => params[:pendingProjectsPage], :per_page => 5)
  end

  # @return @activeProjects
  def active_projects
    @activeProjects = Project.all.where(status: 'active').paginate( :page => params[:activeProjectsPage], :per_page => 5)
  end

  # @return @completedProjects
  def completed_projects
    @completedProjects = Project.all.where(status: 'completed')
  end

  # @return @extraProjects
  def extra_projects
    @extraProjects = Project.all.where(status: 'extra')
  end


  private
  def project_params
    params.require(:project).permit!
  end

  def assignment_params
    params.require(:project_assignment).permit!
  end
end
