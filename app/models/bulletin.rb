# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  IMAGE_MAX_SIZE_MB      = 5.megabytes
  ACCEPTED_CONTENT_TYPES = ['image/png', 'image/jpeg'].freeze

  belongs_to :user
  belongs_to :category

  has_one_attached :image

  validates :title, length: { in: 2..50 }
  validates :description, length: { in: 5..1000 }
  validates :image, attached: true, size: { less_than: IMAGE_MAX_SIZE_MB }, content_type: ACCEPTED_CONTENT_TYPES

  aasm column: :state do
    state :draft, initial: true
    state :under_moderation
    state :published
    state :rejected
    state :archived

    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :archive do
      transitions from: %i[draft under_moderation published rejected], to: :archived
    end
  end

  def self.ransackable_attributes(_ = nil)
    %w[state title]
  end

  def self.ransackable_associations(_ = nil)
    ['category']
  end
end
