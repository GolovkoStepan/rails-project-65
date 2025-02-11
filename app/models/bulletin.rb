class Bulletin < ApplicationRecord
  IMAGE_MAX_SIZE_MB      = 5.megabytes
  ACCEPTED_CONTENT_TYPES = ['image/png', 'image/jpeg'].freeze

  belongs_to :user
  belongs_to :category

  has_one_attached :image

  validates :title, length: { in: 2..50 }
  validates :description, length: { in: 5..1000 }
  validates :image, attached: true, size: { less_than: IMAGE_MAX_SIZE_MB }, content_type: ACCEPTED_CONTENT_TYPES
end
