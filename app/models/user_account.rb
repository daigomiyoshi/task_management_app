class UserAccount < ApplicationRecord
  belongs_to :user

  enum bank_account_type: { savings: 0, checking: 1 }

  validates :bank_name, presence: true
  validates :bank_branch_name, presence: true
  validates :bank_branch_code, presence: true
  validates :bank_account_type, presence: true
  validates :bank_account_code, presence: true
  validates :bank_account_name, presence: true
end
