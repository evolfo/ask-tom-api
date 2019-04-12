class User < ApplicationRecord
	has_many :user_ideas
	has_many :ideas, through: :user_ideas

	validates :name, presence: true, uniqueness: true
	validates :name, format: { with: /\A[a-zA-Z0-9\s]+\z/i, message: "can only contain letters and numbers." }
	validates_length_of :name, maximum: 12
end
