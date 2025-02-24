# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :bulletins, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 30 }

  def self.ransackable_attributes(_ = nil)
    ['id']
  end
end
