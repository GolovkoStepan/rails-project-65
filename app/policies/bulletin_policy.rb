# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
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
    user&.admin? || record_author?
  end

  def update?
    edit?
  end

  def to_moderate?
    record&.may_to_moderate? && (user&.admin? || record_author?)
  end

  def archive?
    record&.may_archive? && (user&.admin? || record_author?)
  end

  private

  def record_author?
    record.user_id == user&.id
  end
end
