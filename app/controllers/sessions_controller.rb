# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authorized, only: %i[new create welcome]

  def new; end

  def login; end

  def destroy
    session.delete(:user_id)
    puts session[:user_id]  # Nothing gets printed to the console here
    redirect_to '/welcome'
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/welcome'
    else
      redirect_to '/login'
    end
  end

  def page_requires_login; end
end
