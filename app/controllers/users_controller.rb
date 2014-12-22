class UsersController < ApplicationController
  before_action :find_current_user, only: [:profile, :new, :update, :edit]

  def new
  end

  def edit
  end


  def update
    respond_to do |f|
      if @user.update(user_params)
        f.html {redirect_to is_student? ? profile_student_path(current_user.student) : profile_teacher_path(current_user.teacher), :flash => { :success => "Success Update" }}
        #f.json {render json: @user, status: :created, location: @user}
      else
        f.html {render action: "new",:flash => { :error => "Error" } }
      end
    end
  end



  def user_params
    params.require(:user).permit!
  end
end
