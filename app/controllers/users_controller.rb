# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @parties = PartyUser.where(host: true)
  end

  def create
    @user = User.new(user_params)
    @user[:email] = @user[:email].downcase
    if @user.save
        flash[:success] = "Welcome, #{@user.name}!"
      redirect_to dashboard_path(@user.id)
    else
      flash[:error] = 'Please fill in all fields.'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
