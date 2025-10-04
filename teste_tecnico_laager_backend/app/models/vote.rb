class Vote < ApplicationRecord
  belongs_to :participant

  scope :order_by_creation, -> { order(created_at: :desc) }
end
