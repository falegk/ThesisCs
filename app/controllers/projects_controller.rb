# noinspection RubyTooManyInstanceVariablesInspection
class ProjectsController < ApplicationController
  before_action :auth_user

  # @return projects
  #before_action :all_projects, only: [ :index, :show ]
  before_action :active_projects, only: [ :index ]
  before_action :pending_projects, only: [ :index ]
  before_action :completed_projects, only: [ :index ]
  before_action :archive_projects, only: [ :archive ]
  before_action :current_project, only: [:show, :update, :destroy, :project_completed,:project_prolongation, :create_assignment,:delete_assignments,:destroy_assignment, :update_assignment ]

  # students valid
  before_action :given_to_students, only: [ :show , :names_of_students]
  before_action :names_of_students, only: [ :show ]
  before_action :expressed_interest, only: [ :show ]
  before_action  :department_empty

  def search
    @results = Project.search_for(params[:search]).paginate(page: params[:page], per_page: 20)
  end


  def index
    if params[:search]
      @results = Project.search(params[:search]).order('created_at DESC')
    else
      @results = Project.all.order('created_at DESC')
    end

    respond_to do |format|
      format.html # index.html.erb
      ajax_respond format, :section_id => 'pendingProjectsPage'
      ajax_respond format, :section_id => 'activeProjectsPage'
    end
  end

  def archive
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
          @currentProject.update(completion_date: @currentProject.start_date+1.year)
        f.html {redirect_to project_path(@currentProject), :flash => { :success => t('messages.success.projects.thesis_update_successfully') }}
        #f.json {render json: @user, status: :created, location: @user}
      else
        f.html {render action: 'edit', :flash => { :error => 'Error'} }
      end
    end
  end

  def update_assignment
      redirect_not_teacher
      # 3 because it sends and an empty value
      if (assignment_params[:student_id].length > 3) || (assignment_params[:student_id].length <= 1)
        #if the job was given to more students
        redirect_to :back,:flash => { :error => 'Δεν μπορείτε να επιλέξετε περισσότερους από 2 φοιτητές.'}
      else
        begin
        Project.transaction do
          @currentProject.project_assignments.where(assignment_params).update_all(given: true)
          @currentProject.project_assignments.where(given: false).destroy_all
          ProjectAssignment.where(assignment_params).destroy_all(given: false)
          @currentProject.update!(status: 'active', start_date: Time.now, completion_date: 1.year.from_now)
        end
           @currentProject.project_assignments.where(given: true).each do |p|
              UserMailer.project_assignment(current_user.teacher,p.student,@currentProject).deliver
           end
          redirect_to :back,:flash => { :success => 'Η πτυχιακή εργασία ανατέθηκε επιτυχώς.'}
        rescue
          redirect_to :back,:flash => { :error => 'Αποτυχία ανάθεσης.'}
        end
      end
  end

  def project_completed
    redirect_not_teacher
    @currentProject.update!(status: 'completed', completion_date: Time.now )
    redirect_to teacher_dashboard_path ,:flash => { :success => t('messages.success.projects.thesis_completed_successfully')}
  end

  def project_prolongation
    redirect_not_teacher
    if @currentProject.prolongation
      redirect_to teacher_dashboard_path , :flash =>  { :notice => t('messages.alert.projects.already_been_given_prolongation')}
    else
      @currentProject.update!(prolongation: true)
      redirect_to teacher_dashboard_path, :flash =>  { :success => t('messages.success.projects.prolongation_has_given_successfully')}
    end
  end

  def delete_assignments
    redirect_not_teacher
    begin
      Project.transaction do
        @currentProject.project_assignments.destroy_all
        @currentProject.update!(status: 'pending', prolongation: false)
      end
      redirect_to teacher_dashboard_path, :flash => { :success => 'Η πτυχιακή μεταφέρθηκε επιτυχώς στις "Διαθέσιμες Πτυχιακές" και είναι έτοιμη να δοθεί σε άλλους φοιτητές.' }
    rescue
      redirect_to teacher_dashboard_path, :flash => { :error => 'Η ενέργεια απέτυχε.' }
    end

  end

  # Expression of interest from the student
  def create_assignment
    @currentProject.project_assignments.create(student_id: current_user.student.id)
    UserMailer.expression_interest(@currentProject.teacher,current_user.student,@currentProject).deliver
    redirect_to project_path(@currentProject.id)
  end

  def destroy_assignment
    @currentProject.project_assignments.find_by(student_id: current_user.student.id).destroy
    redirect_to project_path(params[:id])
  end

  def expressed_interest
    @studentsList = @currentProject.project_assignments.all
  end


  #@return @given_project_to_students
  # returns a table with up to 2 records are given: true by project_assignments table
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
    @activeProjects = Project.all.where(status: 'active').order('start_date DESC').paginate( :page => params[:activeProjectsPage], :per_page => 5)
  end

  # @return @completedProjects
  def completed_projects
    @completedProjects = Project.all.where(status: 'completed').limit(5)
  end

  # @return @archiveProjects
  def archive_projects
    @archiveProjects = Project.all.where(status: 'completed').paginate( :page => params[:archiveProjectsPage], :per_page => 20)
  end


  private
  def project_params
    params.require(:project).permit!
  end

  def assignment_params
    params.require(:project_assignment).permit!
  end

  def search_params
    params[:search]
  end
end
