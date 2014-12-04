class WelcomeController < ApplicationController
  # Ελέγχουν αν υπάρχει ρόλος στον user (μέσα απο την μέθοδο is_student_or_teacher)
  # άν δεν υπάρχει, τρέχει η add_role_to_user
  before_action  :is_student_or_teacher?
  before_action  :add_role_to_user, if: :is_student_or_teacher?

  # View methods
  def index
  end


end
