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
    user = User.new(user_params)
    user.email = user.email.downcase
    if user.password != user.password_confirmation
      flash[:error] = "Password and confirmation do not match!"
      render :new
    elsif user.save
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to dashboard_path(user.id)
    else
      flash[:error] = 'Please fill in all fields.'
      render :new
    end
  end
  
  def login_form; end
  
  def login
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to root_path
    else
      flash[:error] = "Sorry, incorrect credentials."
      render :login_form
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Logged Out!"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
