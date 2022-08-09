class Project < ApplicationRecord
  has_many :users, through: :user_projects
  has_many :user_projects

	with_options presence: true do
    validates :title, length: { maximum: 50 }
    validates :category
    validates :deadline
  end
end
