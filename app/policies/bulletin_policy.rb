# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.published unless user
      return scope.all if user.admin?

      scope.where(state: :published).or(scope.where(user:))
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def new?
    user.present?
  end

  def create?
    new?
  end

  def edit?
    user&.admin? || user&.owns?(record)
  end

  def update?
    edit?
  end

  def to_moderate?
    resource&.may_to_moderate? && (user&.admin? || user&.owns?(record))
  end

  def archive?
    resource&.may_archive? && (user&.admin? || user&.owns?(record))
  end
end
