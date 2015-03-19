class ApplicationController < ActionController::Base
  TEACHER_REGEX = /\AΕΚΠΑΙΔΕΥΤΙΚΟΣ[\p{Any}*]*\Z/
  STUDENT_REGEX = /\AΣΠΟΥΔΑΣΤΗΣ[\p{Any}*]*\Z/

  layout 'thesis2/thesis2'

  #before_action :authenticate_user!

  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # for before_action :auth_user
  def auth_user
    redirect_to root_path unless user_signed_in?
  end

  #checks if the user has chosen department
  def department_empty
    if is_student?
      if current_user.student.department.blank?
        redirect_to edit_student_path(current_user.student), notice: 'Πρέπει να επιλέξετε τμήμα.'
      end
    elsif is_teacher?
      if current_user.teacher.department.blank?
        redirect_to edit_teacher_path(current_user.teacher), notice: 'Πρέπει να επιλέξετε τμήμα.'
      end
    end
  end

  # --------------- Γενικές μέθοδοι για έλεγχο των Project -----------------

  # @return @currentProject
  def current_project
    @currentProject = Project.find(params[:id])
  end

  # ------------ Γενικές μέθοδοι για έλεγχο των χρηστών --------------------

  # Ελέγχει άν ο user είναι καταχωριμένος σαν φοιτητής ή σαν καθηγητής
  # Επιστρέφει *false αν είναι κάτι απο τα 2, ή *true αν δεν έχει ακόμα ΚΑΝΕΝΑ ρόλο.
  def has_role?
    !is_student? && !is_teacher?
  end

  def is_student?
    current_user.student
  end

  def is_teacher?
    current_user.teacher
  end

  #Αν ο χρήστης που είναι συνδεδεμένος δεν έχει τον ρόλο του καθηγητή, ανακατευθύνετε στην root_page
  def redirect_not_teacher
    unless current_user.teacher
      redirect_to root_path
    end
  end

  #Αν ο χρήστης που είναι συνδεδεμένος δεν έχει τον ρόλο του φοιτητή, ανακατευθύνετε στην root_page
  def redirect_not_student
    unless current_user.student
      redirect_to root_path
    end
  end

  # Προσθέτει ρόλο στον χρήστη (Student or Teacher),και περνάει βασικά στοιχεία στην βάση (ονομα, επώνυμο, Α.Μ )
  def add_role_to_user
    ldap_values = get_ldap_values
    user = User.all.find(current_user)
    if get_user_role_from_ldap(user) == 'student'
      user.update(first_name: ldap_values[:firstname],last_name: ldap_values[:lastname])
      user.create_student
      redirect_to edit_student_path(user.student)
    elsif get_user_role_from_ldap(user) == 'teacher'
      user.update(first_name: ldap_values[:firstname],last_name: ldap_values[:lastname])
      user.create_teacher
      user.teacher.update(dissertation_number: ThesisCs::Application::NUMBER_OF_PENDING_DISSERTATIONS)
      redirect_to edit_teacher_path(user.teacher)
    else
      # Αν δεν ειναι teacher or student διαγραφει την εγγραφη
      user.destroy
      redirect_to root_path, flash: {notice: 'Δεν έχετε δικαίωμα πρόσβασης'}
    end

  end


  # Ελέγχει τον ρόλο του χρήστη στο LDAP του Τ.Ε.Ι
  #@param user [User]
  #@return student, teacher or none [String]
  def get_user_role_from_ldap(user)
    role = user.get_ldap_userType
    if role.match(TEACHER_REGEX) #Τιμή στο businessCategory του LDAP
      'teacher'
    elsif role.match(STUDENT_REGEX) #Τιμή στο businessCategory του LDAP
      'student'
    end
  end

  # Τραβάει τιμές του χρήστη απο το LDAP
  #@return [Hash]
  def get_ldap_values
    firstname = Devise::LDAP::Adapter.get_ldap_param(current_user.email,"cn").first.force_encoding("UTF-8")
    lastname =  Devise::LDAP::Adapter.get_ldap_param(current_user.email,"sn").first.force_encoding("UTF-8")

    { firstname: firstname, lastname: lastname } #επιστρέφει ένα hash με πολλές τιμές
  end

  #Δημιουργεί ένα αντικείμενο @User του χρήστη που είναι συνδεδεμένος
  def find_current_user
    @user = User.all.find(current_user)
  end


end
