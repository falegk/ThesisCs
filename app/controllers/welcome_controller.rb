class WelcomeController < ApplicationController
  before_action :auth_user
  # Ελέγχουν αν υπάρχει ρόλος στον user
  # άν δεν υπάρχει, τρέχει η add_role_to_user
  before_action  :has_role?
  before_action  :add_role_to_user, if: :has_role?
  before_action  :department_empty


  # View methods
  def index
  end


end
