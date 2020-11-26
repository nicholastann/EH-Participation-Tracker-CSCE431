# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    @current_user.role == 'admin'
  end

  def new?
    @current_user.role == 'admin'
  end

  def update?
    @current_user.role == 'admin'
  end

  def edit?
    @current_user.role == 'admin'
  end

  def destroy?
    @current_user.role == 'admin'
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
