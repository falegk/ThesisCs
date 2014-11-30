class ApplicationController < ActionController::Base
  #before_action :authenticate_user!
  before_action :check_users_type

  layout "thesisCs/thesisCs"
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #before_action :configure_permitted_parameters, if: :devise_controller?


  #checks if the user has chosen department
  def department_empty?
     User.find(current_user) do |p|
      if p.student.department == nil
        redirect_to profile_path
      else
        @ok = 'ok'
      end
     end

  end



  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
  end

  #check user if a student or teacher
  def check_users_type
    @user = User.all.find(current_user) do |p|
      if p.student == nil
          p.create_student
          redirect_to profile_path
      else
        @ok = "This user ( #{p.email} ) is a student"
      end
    end
  end

end
