# frozen_string_literal: true

class ProfilePolicy < ApplicationPolicy
  def show?
    user.present?
  end
end
