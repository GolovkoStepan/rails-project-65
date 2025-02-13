# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :bulletins, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true, length: { in: 2..30 }

  def self.ransackable_attributes(_auth_object = nil)
    ['id']
  end
end
