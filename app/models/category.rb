class Category < ApplicationRecord
  has_many :bulletins, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true, length: { in: 2..30 }
end
