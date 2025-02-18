class Feedback < ApplicationRecord
  belongs_to :user, optional: true

  validates :podcast_id, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true, length: { maximum: 500 }
end