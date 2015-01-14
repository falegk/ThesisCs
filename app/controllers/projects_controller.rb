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

  # routes
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
    redirect_to teacher_dashboard_path , notice: 'Η Πτυχιακή διαγράφηκε επιτυχώς.'
  end

  def create
    redirect_not_teacher
    @project = Project.new(project_params)
    @project.teacher = current_user.teacher
    respond_to do |f|
      if @project.save
        f.html {redirect_to project_path(@project), :flash => { :success => "Success create" }}
        #f.json {render json: @user, status: :created, location: @user}
      else
        f.html {render template: 'teachers/add_project' , :flash => { :error => "Error" } }
      end
    end
  end

  # update project from teacher /user/teacher/:id/projects/:id/edit
  def update
    redirect_not_teacher
    respond_to do |f|
      if @currentProject.update(project_params)
        f.html {redirect_to project_path(@currentProject), :flash => { :success => "Success Update Project" }}
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
        ProjectAssignment.all.where(student_id: assignment_params[:student_ids], given: false).destroy_all
        @currentProject.update!(status: 'active', start_date: Time.now, completion_date: 1.year.from_now)

        redirect_to project_path(params[:id])
  end

  def project_completed
    redirect_not_teacher
    @currentProject.update!(status: 'completed')
    redirect_to teacher_dashboard_path , notice: 'Η Πτυχιακή ολοκληρώθηκε επιτυχώς.'
  end

  def project_prolongation
    redirect_not_teacher
    if @currentProject.prolongation == true
      redirect_to teacher_dashboard_path , notice: 'Έχει ήδη δοθεί παράταση.'
    else
      @currentProject.update!(prolongation: true)
      redirect_to teacher_dashboard_path
    end
  end

  def delete_assignments
    redirect_not_teacher
    @currentProject.project_assignments.destroy_all
    @currentProject.update!(status: 'pending', prolongation: false)
    redirect_to teacher_dashboard_path

  end

  # Αν δεν υπάρχει εκδήλωση ενδιαφέροντος ενός θέματος απο εναν φοιτητή ,
  # τότε (με ένα button) γίνεται δημιουργία. Άν υπάρχει τότε γίνεται διαγραφή
  def create_assignment
    @currentProject.project_assignments.create(student_id: current_user.student.id)
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


  private
  def project_params
    params.require(:project).permit!
  end

  def assignment_params
    params.require(:project_assignment).permit!
  end
end
