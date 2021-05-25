class PaymentResult < ApplicationRecord
  belongs_to :user
  belongs_to :project

  scope :filter_by_user, -> (user_id) { where(user_id: user_id) }

  def change_blank_to_nil
    self.payment_note_url.blank? ? nil : self.payment_note_url
  end
end
