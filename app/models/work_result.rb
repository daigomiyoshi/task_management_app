class WorkResult < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :project_category

  validates :working_on, presence: true
  validates :working_hours, length: { minimum: 0, maximum: 24 }

  scope :filter_by_year_month, -> (year, month) { 
    where("YEAR(working_on) = ? and MONTH(working_on) = ?", year, month) 
  }
  scope :filter_by_year_month_day, -> (year, month, day) { 
    where("YEAR(working_on) = ? and MONTH(working_on) = ? and DAY(working_on) = ?", year, month, day) 
  }

  def get_start_at_view
    if start_at.nil?
      "00:00"
    else
      I18n.l(start_at, format: :hour_minutes)
    end
  end
end
