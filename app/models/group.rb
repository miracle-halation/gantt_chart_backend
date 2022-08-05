class Group < ApplicationRecord
	validates :name, presence: true, length: { maximum: 50 }
	has_many :projects, dependent: :destroy
end
