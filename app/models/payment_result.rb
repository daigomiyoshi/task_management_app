class PaymentResult < ApplicationRecord
  belongs_to :user
  belongs_to :project

  scope :filter_by_user, -> (user_id) { where(user_id: user_id) }
end
