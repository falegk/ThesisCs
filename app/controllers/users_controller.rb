class UsersController < ApplicationController
  #before_action :check_users_type, only: [:profile]
  before_action :find_current_user, only: [:profile, :new, :update]

  def profile
  end

  def new
  end


  def update
    respond_to do |f|
      if @us.update(user_params)
        f.html {redirect_to profile_path, :flash => { :success => "Success Update" }}
        f.json {render json: @us, status: :created, location: @us}
      else
        f.html {render action: "new",:flash => { :error => "Error" } }
      end
    end
  end


  def find_current_user
    @us = User.all.find(current_user)
  end

  def user_params
    params.require(:user).permit!
  end
end
