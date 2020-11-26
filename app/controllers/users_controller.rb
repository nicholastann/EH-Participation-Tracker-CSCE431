# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authorized, only: %i[new create]
  after_action :verify_authorized, only: []

  def new
    @user = User.new
  end

  def create
    @user = User.create(params.require(:user).permit(:email, :password))
    session[:user_id] = @user.id
    redirect_to '/welcome'
  end
end
