class WelcomeController < ApplicationController
  # Ελέγχουν αν υπάρχει ρόλος στον user (μέσα απο την μέθοδο is_student_or_teacher)
  # άν δεν υπάρχει, τρέχει η add_role_to_user
  before_action  :has_role?
  before_action  :add_role_to_user, if: :has_role?

  # View methods
  def index
    @test = has_role?
  end


end
