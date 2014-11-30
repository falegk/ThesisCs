class StudentsController < ApplicationController

  def show
    @user.build_student
  end
end
