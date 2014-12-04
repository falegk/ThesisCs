class ApplicationController < ActionController::Base
  layout "thesisCs/thesisCs"

  before_action :authenticate_user!


  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #before_action :configure_permitted_parameters, if: :devise_controller?


  #checks if the user has chosen department

  def department_empty
     User.find(current_user) do |p|
      if p.student.department == nil
        redirect_to profile_path, notice: "Πρέπει να επιλέξετε τμήμα."
     end
    end
  end


  # ------------ Γενικές μέθοδοι για έλεγχο τον χρηστών --------------------

  # Ελέγχει άν ο user είναι καταχωριμένος σαν φοιτητής ή σαν καθηγητής
  # Επιστρέφει true αν είναι κάτι απο τα 2, ή false αν δεν έχει ακόμα ρόλο.
  def is_student_or_teacher?
    current_user.student.blank? && current_user.student.blank?
  end


  # Προσθέτει ρόλο στον χρήστη
  def add_role_to_user
    ldap_values = get_ldap_values
    user = User.all.find(current_user)
    if get_user_role(user) == "student"
      user.create_student
    elsif get_user_role(user) == "teacher"
      user.create_teacher
    end
    user.update(first_name: ldap_values[:firstname],last_name: ldap_values[:lastname])
  end


  # Ελέγχει τον ρόλο του χρήστη στο LDAP του Τ.Ε.Ι
  def get_user_role(user)
    if user.get_ldap_userType == "ΣΠΟΥΔΑΣΤΗΣ" #Τιμή στο businessCategory του LDAP
      "student"
    elsif user.get_ldap_userType == "ΚΑΘΗΓΗΤΗΣ" #Τιμή στο businessCategory του LDAP
      "teacher"
    else
      "none"
    end
  end

  # Τραβάει τιμές του χρήστη απο το LDAP και τις επιστρέφει με hash
  def get_ldap_values
    firstname = Devise::LDAP::Adapter.get_ldap_param(current_user.email,"cn").first.force_encoding("UTF-8")
    lastname =  Devise::LDAP::Adapter.get_ldap_param(current_user.email,"sn").first.force_encoding("UTF-8")

    { firstname: firstname, lastname: lastname } #επιστρέφει ένα hash με πολλές τιμές
  end




end
