# frozen_string_literal: true

module Admin
  class BulletinPolicy < ApplicationPolicy
    def index?
      user&.admin?
    end

    def under_moderation?
      index?
    end

    def archive?
      index?
    end

    def publish?
      index?
    end

    def reject?
      index?
    end
  end
end
