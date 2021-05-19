class Project < ApplicationRecord
  has_many :user_in_charges, dependent: :destroy
  has_many :users, through: :user_in_charges

  enum project_status: { finished: 0, doing: 1 }

  validates :project_name, presence: true

  def project_name_with_status
    if finished?
      "#{project_name}（終了）"
    elsif doing?
      "#{project_name}（稼働中）"
    end
  end
end
