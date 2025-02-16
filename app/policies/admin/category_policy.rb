# frozen_string_literal: true

module Admin
  class CategoryPolicy < ApplicationPolicy
    def index?
      user&.admin?
    end

    def new?
      index?
    end

    def edit?
      index?
    end

    def create?
      index?
    end

    def update?
      index?
    end

    def destroy?
      index?
    end
  end
end
