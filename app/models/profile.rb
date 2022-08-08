class Profile < ApplicationRecord

	belongs_to :users
	with_options presence: true do
    validates :name, length: { maximum: 50 }
    validates :group
  end
end
