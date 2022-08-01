class Group < ApplicationRecord
	validates :name, presence: true, length: { maximum: 50 }
	has_many :users
	has_many :projects
end
