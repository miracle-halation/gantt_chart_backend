class Project < ApplicationRecord

	with_options presence: true do
    validates :title, length: { maximum: 50 }
    validates :category
    validates :deadline
  end
end
