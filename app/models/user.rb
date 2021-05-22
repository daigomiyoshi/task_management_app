class User < ApplicationRecord
  authenticates_with_sorcery!

  has_one :user_account, dependent: :destroy
  has_many :user_in_charges, dependent: :destroy
  has_many :projects, through: :user_in_charges
  has_many :work_results, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  enum role: { general: 0, admin: 1 }

  def full_name
    "#{last_name} #{first_name}"
  end
end
