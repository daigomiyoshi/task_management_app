class WorkResult < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :project_category
end
