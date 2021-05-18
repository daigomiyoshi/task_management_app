class UserAccount < ApplicationRecord
  belongs_to :user

  enum bank_account_type: { savings: 0, checking: 1 }
end
