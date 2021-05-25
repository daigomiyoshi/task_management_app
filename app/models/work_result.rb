class WorkResult < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :project_category, optional: true

  validates :working_on, presence: true
  validates :working_hours, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 24 }

  scope :filter_by_year_month, -> (year, month) { 
    where("YEAR(working_on) = ? and MONTH(working_on) = ?", year, month) 
  }
  scope :filter_by_year_month_day, -> (year, month, day) { 
    where("YEAR(working_on) = ? and MONTH(working_on) = ? and DAY(working_on) = ?", year, month, day) 
  }
  scope :get_monthly_total_working_hours, -> (user_id, project_id, year, month) {
    if self.has_user_project_work_result(user_id, project_id, year, month)
      where(
        "user_id = ? and project_id = ? and YEAR(working_on) = ? and MONTH(working_on) = ?", 
        user_id, project_id, year, month
      ).group("YEAR(working_on)", "MONTH(working_on)").sum(:working_hours).values[0].round(1)
    else
      0
    end
  }

  def self.has_user_project_work_result(user_id, project_id, year, month)
    where("user_id = ? and project_id = ? and YEAR(working_on) = ? and MONTH(working_on) = ?", 
      user_id, project_id, year, month).exists?
  end

  def self.aggregate_monthly_working_results
    query = "
      WITH aggregated_monthly_working_result AS (
        SELECT 
        user_id, project_id, LAST_DAY(DATE_FORMAT(working_on, '%Y-%m-01')) as working_month,
        ROUND(SUM(working_hours), 2) as total_working_hours,
        COUNT(working_hours) as count_results
        FROM work_results
        GROUP BY user_id, project_id, LAST_DAY(DATE_FORMAT(working_on, '%Y-%m-01'))
      )
      SELECT 
        a.user_id, a.project_id, a.working_month,
        a.total_working_hours, c.user_wage, 
        a.total_working_hours * c.user_wage AS payment_amount,
        a.count_results,
        DAY(a.working_month) AS monthly_days
      FROM aggregated_monthly_working_result AS a
      LEFT JOIN payment_results AS b
      ON a.user_id = b.user_id
      AND a.project_id = b.project_id
      AND a.working_month = b.working_month
      LEFT JOIN user_in_charges AS c
      ON a.user_id = c.user_id
      AND a.project_id = c.project_id
      WHERE b.id IS NULL
    "
    ActiveRecord::Base.connection.select_all(query)
  end
end
