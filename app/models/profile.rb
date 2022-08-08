class Profile < ApplicationRecord

	belongs_to :user
	with_options presence: true do
    validates :name, length: { maximum: 50 }
    validates :group
  end
end
