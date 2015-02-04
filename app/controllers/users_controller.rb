class UsersController < ApplicationController
  before_action :auth_user
  before_action :find_current_user, only: [:profile, :new, :update, :edit]


  def new
  end

  def edit
  end


  def update
    respond_to do |f|
      if @user.update(user_params)
        f.html {redirect_to is_student? ? profile_student_path(current_user.student) : profile_teacher_path(current_user.teacher), :flash => { :success => t('messages.success.data_storage')}}
        #f.json {render json: @user, status: :created, location: @user}
      else
        f.html {redirect_to :back ,:flash => { :error => "Κάτι πήγε στραβά. Σιγουρευτείτε ότι συμπληρώσατε όλα τα απαραίτητα πεδία." } }
      end
    end
  end


private
  def user_params
    params.require(:user).permit!
  end
end
