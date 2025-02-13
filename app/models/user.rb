# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bulletins, dependent: :restrict_with_error

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  def owns?(resource)
    resource.user_id == id
  end
end
